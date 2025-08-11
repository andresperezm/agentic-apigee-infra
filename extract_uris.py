from pathlib import Path
from typing import Set
from bs4 import BeautifulSoup, Tag

# --- Configuration ---
INPUT_FOLDER = 'doc_menu'
INPUT_GLOB = '*guides.html'
OUTPUT_FILENAME = 'uris.tfvars'
# -------------------


def extract_uris_from_file(file_path: Path) -> Set[str]:
    """Extracts relevant URIs from a single HTML file."""
    uris: Set[str] = set()
    print(f"  - Processing {file_path}")
    with file_path.open('r', encoding='utf-8') as f:
        soup = BeautifulSoup(f.read(), 'html.parser')
        for a_tag in soup.find_all('a', href=True):
            if not isinstance(a_tag, Tag):
                continue

            href = a_tag.get('href')
            if not isinstance(href, str) or not ('get-started' in href or 'fundamentals' in href):
                continue

            if href.startswith('https://cloud.google.com'):
                uris.add(href.removeprefix('https://'))
            elif href.startswith('/apigee/'):
                uris.add('cloud.google.com' + href)
    return uris


def write_tfvars(uris: Set[str], output_file: Path):
    """Writes the set of URIs to a .tfvars file."""
    # Sort for consistent, deterministic output
    sorted_uris = sorted(list(uris))

    if not sorted_uris:
        content = "uris = []\n"
    else:
        formatted_uris = '",\n  "'.join(sorted_uris)
        content = f'uris = [\n  "{formatted_uris}"\n]\n'

    output_file.write_text(content, encoding='utf-8')
    print(f"\nFinished! Extracted {len(uris)} unique uris to '{OUTPUT_FILENAME}'.")


def main():
    """Scans a directory for HTML files, extracts URIs, and saves them to a tfvars file."""
    input_dir = Path(INPUT_FOLDER)
    output_file = Path(OUTPUT_FILENAME)

    if not input_dir.is_dir():
        print(f"Error: The folder '{input_dir}' was not found.")
        return

    all_hrefs: Set[str] = set()
    print(f"Scanning folder: '{input_dir}'...")

    for file_path in input_dir.glob(INPUT_GLOB):
        all_hrefs.update(extract_uris_from_file(file_path))

    write_tfvars(all_hrefs, output_file)


if __name__ == "__main__":
    main()