
CREATE TABLE city (
    city_id INT PRIMARY KEY AUTO_INCREMENT,
    city_name VARCHAR(50) NOT NULL UNIQUE
);

INSERT INTO city (city_name) VALUES ('Bengali,2D');

CREATE TABLE theatre (
    theatre_id INT PRIMARY KEY AUTO_INCREMENT,
    theatre_name VARCHAR(50) NOT NULL,
    city_id INT NOT NULL,
    FOREIGN KEY (city_id) REFERENCES city(city_id)
);

INSERT INTO theatre (theatre_name, city_id)
VALUES ('PVR: Nexus Forum Mall', 1);

CREATE TABLE movie (
    movie_id INT PRIMARY KEY AUTO_INCREMENT,
    movie_name VARCHAR(50) NOT NULL,
    movie_language VARCHAR(50),
    movie_format VARCHAR(10)
);

INSERT INTO movie (movie_name, movie_language, movie_format)
VALUES
('Dasara', 'Telugu', '2D'),
('Kisi Ka Bhai Kisi Ki Jaan', 'Hindi', '2D'),
('Tu Jhoothi Main Makkaar', 'Hindi', '2D'),
('Avatar: The Way of Water', 'English', '3D');



CREATE TABLE screen (
    screen_id INT PRIMARY KEY AUTO_INCREMENT,
    theatre_id INT NOT NULL,
    screen_number INT NOT NULL,
    FOREIGN KEY (theatre_id) REFERENCES theatre(theatre_id),
    UNIQUE (theatre_id, screen_number)
);

INSERT INTO screen (theatre_id, screen_number)
VALUES (1, 1), (1, 2), (1, 3);


CREATE TABLE movie_show (
    show_id INT PRIMARY KEY AUTO_INCREMENT,
    movie_id INT NOT NULL,
    theatre_id INT NOT NULL,
    show_date DATE NOT NULL,
    FOREIGN KEY (movie_id) REFERENCES movie(movie_id),
    FOREIGN KEY (theatre_id) REFERENCES theatre(theatre_id),
    UNIQUE (movie_id, theatre_id, show_date)
);

INSERT INTO movie_show (movie_id, theatre_id, show_date)
VALUES
(1, 1, '2023-04-25'),
(2, 1, '2023-04-25'),
(3, 1, '2023-04-25'),
(4, 1, '2023-04-25');


CREATE TABLE show_timing (
    show_timing_id INT PRIMARY KEY AUTO_INCREMENT,
    show_id INT NOT NULL,
    screen_id INT NOT NULL,
    start_time TIME NOT NULL,
    FOREIGN KEY (show_id) REFERENCES movie_show(show_id),
    FOREIGN KEY (screen_id) REFERENCES screen(screen_id),
    UNIQUE (screen_id, start_time)
);

INSERT INTO show_timing (show_id, screen_id, start_time)
VALUES
(1, 1, '12:15:00'),
(2, 2, '10:00:00'),
(2, 2, '04:10:00'),
(2, 3, '06:20:00'),
(3, 1, '01:15:00'),
(4, 3, '01:20:00');

SELECT
    m.movie_name,
    m.movie_language,
    m.movie_format,
    st.start_time,
    sh.show_date,
    sc.screen_number
FROM theatre t
JOIN movie_show sh ON sh.theatre_id = t.theatre_id
JOIN movie m ON m.movie_id = sh.movie_id
JOIN show_timing st ON st.show_id = sh.show_id
JOIN screen sc ON sc.screen_id = st.screen_id
WHERE
    t.theatre_name = 'PVR: Nexus Forum Mall'
    AND sh.show_date = '2023-04-25'
ORDER BY
    m.movie_name,
    st.start_time;



