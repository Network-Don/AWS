import os
import re

def extract_title(file_path):
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            for line in f:
                line = line.strip()
                if line.startswith('#'):
                    # Strip leading '#'
                    text = line.lstrip('#').strip()
                    # Strip leading emojis/symbols
                    text = re.sub(r'^[^a-zA-Z0-9]*', '', text).strip()
                    # Split by en-dash, em-dash, or hyphen
                    parts = re.split(r'\s*(?:[–—]|-)\s*', text, maxsplit=1)
                    if len(parts) > 1:
                        # If first part looks like "Week X Day Y" or "Day X", use the second part
                        if re.match(r'^(?:Week\s*\d+\s*Day\s*\d+|Week\s*\d+\s*[·\s-]*\s*Day\s*\d+|Day\s*\d+)', parts[0], re.IGNORECASE):
                            return parts[1].strip()
                        else:
                            return text
                    else:
                        return text
    except Exception as e:
        print(f"Error reading {file_path}: {e}")
    return "Untitled"

def main():
    days_dir = "days"
    readme_path = "README.md"
    
    if not os.path.exists(days_dir):
        print(f"Directory '{days_dir}' not found.")
        return
        
    if not os.path.exists(readme_path):
        print(f"File '{readme_path}' not found.")
        return
        
    # Find all day-*.md files
    day_files = []
    pattern = re.compile(r'^day-(\d+)(?:-[\w-]+)?\.md$')
    for filename in os.listdir(days_dir):
        match = pattern.match(filename)
        if match:
            day_num = int(match.group(1))
            day_files.append((day_num, filename))
            
    if not day_files:
        print("No day markdown files found.")
        return
        
    # Group days by week (5 days per week)
    weeks = {}
    for day_num, filename in day_files:
        week = (day_num - 1) // 5 + 1
        if week not in weeks:
            weeks[week] = []
        
        file_path = os.path.join(days_dir, filename)
        title = extract_title(file_path)
        weeks[week].append((day_num, title, filename))
        
    # Generate progress content
    week_blocks = []
    for week in sorted(weeks.keys()):
        week_lines = [f"**Week {week}**"]
        # Sort days numerically within the week
        for day_num, title, filename in sorted(weeks[week], key=lambda x: x[0]):
            day_in_week = (day_num - 1) % 5 + 1
            week_lines.append(f"- ✅ **[Day {day_in_week}: {title}](./days/{filename})**  ")
        week_blocks.append("\n".join(week_lines))
        
    progress_content = "\n\n<br>\n\n".join(week_blocks)
    
    # Read README.md
    with open(readme_path, 'r', encoding='utf-8') as f:
        readme_content = f.read()
        
    # Replace content between markers
    start_marker = "<!-- START_PROGRESS_TRACKER -->"
    end_marker = "<!-- END_PROGRESS_TRACKER -->"
    
    start_idx = readme_content.find(start_marker)
    end_idx = readme_content.find(end_marker)
    
    if start_idx == -1 or end_idx == -1:
        print("Error: Could not find progress tracker comment markers in README.md.")
        return
        
    new_readme = (
        readme_content[:start_idx + len(start_marker)] +
        "\n" + progress_content + "\n" +
        readme_content[end_idx:]
    )
    
    with open(readme_path, 'w', encoding='utf-8') as f:
        f.write(new_readme)
        
    print("Successfully updated README.md progress section!")

if __name__ == "__main__":
    main()
