import requests
from bs4 import BeautifulSoup


UID: int = 12441
URL: str = f"https://www.kinopoisk.ru/user/{UID}/votes/perpage/200/page/1/"
HEADERS: dict = {
    "User-Agent": "Mozilla/5.0 (X11; Linux x86_64; rv:71.0) Gecko/20100101 Firefox/71.0"
}
session = requests.Session()
session.headers.update(HEADERS)


def load_user_data(uid, page, session):
    URL: str = f"https://www.kinopoisk.ru/user/{uid}/votes/perpage/200/page/{page}/"
    response = session.get(URL)
    response.encoding = "utf-8"
    return response.text


def contain_movies_data(text):
    soup = BeautifulSoup(text, features="lxml")
    film_list = soup.find("div", {"class": "profileFilmsList"})
    return film_list is not None


def read_file(filename):
    with open(filename) as input_file:
        text = input_file.read()
    return text


def parse_user_datafile_bs(filename):
    results = []
    text = read_file(filename)

    soup = BeautifulSoup(text)
    film_list = soup.find("div", {"class": "profileFilmsList"})
    items = film_list.find_all("div", {"class": ["item", "item even"]})
    for item in items:
        movie_link = item.find("div", {"class": "nameRus"}).find("a").get("href")
        movie_desc = item.find("div", {"class": "nameRus"}).find("a").text
        movie_id = re.findall("\d+", movie_link)[0]

        name_eng = item.find("div", {"class": "nameEng"}).text

        watch_datetime = item.find("div", {"class": "date"}).text
        date_watched, time_watched = re.match(
            "(\d{2}\.\d{2}\.\d{4}), (\d{2}:\d{2})", watch_datetime,
        ).groups()

        user_rating = item_find("div", {"class": "vote"}).text
        if user_rating:
            user_rating = int(user_rating)

        results.append(
            {
                "movie_id": movie_id,
                "name_eng": name_eng,
                "date_watched": date_watched,
                "time_watched": time_watched,
                "user_rating": user_rating,
                "movie_desc": movie_desc,
            }
        )
    return results


page = 1
while True:
    data = load_user_data(UID, page, session)
    if contain_movies_data(data):
        with open(f"./page_{page}.html", "w") as output_file:
            output_file.write(data)
            page += 1
    else:
        break
