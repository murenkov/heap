import requests
from bs4 import BeautifulSoup

response = requests.get("https://xakep.ru")
page = response.text
soup = BeautifulSoup(page, 'html.parser')

headings = map(lambda e: e.text, soup.select("h3.entry-title a span"))
for h in headings:
    print(h)
