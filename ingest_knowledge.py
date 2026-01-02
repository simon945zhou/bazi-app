import os
from knowledge_base import KnowledgeBase

def ingest_docs():
    kb = KnowledgeBase()
    docs_dir = 'knowledge_docs'
    
    if not os.path.exists(docs_dir):
        os.makedirs(docs_dir)
        print(f"Created directory: {docs_dir}")
        print("Please place your PDF or DOCX files in this directory and run this script again.")
        return

    files = os.listdir(docs_dir)
    if not files:
        print(f"No files found in {docs_dir}. Please add PDF or DOCX files.")
        return

    print(f"Found {len(files)} files. Starting ingestion...")
    
    for filename in files:
        file_path = os.path.join(docs_dir, filename)
        if filename.lower().endswith('.docx'):
            print(f"Processing {filename}...")
            kb.parse_docx(file_path, '命理典籍', filename)
        elif filename.lower().endswith('.pdf'):
            print(f"Processing {filename}...")
            kb.parse_pdf(file_path, '命理典籍', filename)
        else:
            print(f"Skipping {filename} (unsupported format)")
            
    print("Ingestion complete. Knowledge base updated.")

if __name__ == '__main__':
    ingest_docs()
