from setuptools import setup, find_packages

with open("README.md", "r", encoding="utf-8") as fh:
    long_description = fh.read()

setup(
    name="suanming_app",
    version="1.0.0",
    author="天纪爱好者",
    author_email="example@example.com",
    description="基于倪海厦老师《天纪》内容的算命系统",
    long_description=long_description,
    long_description_content_type="text/markdown",
    url="",
    packages=find_packages(),
    classifiers=[
        "Programming Language :: Python :: 3",
        "License :: OSI Approved :: MIT License",
        "Operating System :: OS Independent",
    ],
    python_requires='>=3.6',
    install_requires=[
        'pandas',
        'python-docx',
        'pdfplumber',
        'openpyxl',
        'pyqt5',
    ],
    entry_points={
        'console_scripts': [
            'suanming_app=main_app:main',
        ],
    },
)