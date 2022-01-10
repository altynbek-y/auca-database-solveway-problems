--Movie/Show streaming, DDL code in SQL 
--Database 2021, AUCA
--12/16/2021
--by students: Altynbek uulu Yiman, Anastasia Frolova
--professor: Andrey Gurinov


----------USER-ACCOUNT-ETC-RELATED-TABLES--------------------------------------------------------
CREATE TABLE Regions (
    ID INT NOT NULL PRIMARY KEY,
    Region_name NVARCHAR(100) NOT NULL
		CONSTRAINT U_region_name UNIQUE
)
GO

CREATE TABLE Countries (
    ID BIGINT NOT NULL PRIMARY KEY,
    Country_name NVARCHAR(100) NOT NULL
		CONSTRAINT U_country_name UNIQUE,
    Region_id INT NOT NULL
        CONSTRAINT FK_countries_region FOREIGN KEY REFERENCES Regions (ID)
)
GO

CREATE TABLE Locations (
    ID BIGINT NOT NULL PRIMARY KEY,
    City NVARCHAR(100) NOT NULL,
    Country_id BIGINT NOT NULL
        CONSTRAINT FK_locations_country FOREIGN KEY REFERENCES Countries (ID)
)
GO 
CREATE TABLE User_locations (
    ID INT NOT NULL PRIMARY KEY,
    Street_address NVARCHAR(200) NOT NULL,
    Postal_code INT NOT NULL,
    City NVARCHAR(100) NOT NULL,
    State_province NVARCHAR(100) NOT NULL,
    Country_id BIGINT NOT NULL
        CONSTRAINT FK_user_locations_country FOREIGN KEY REFERENCES Countries (ID)
)
GO

CREATE TABLE Users (
    ID BIGINT NOT NULL PRIMARY KEY,
    First_name NVARCHAR(100) NOT NULL,
    Last_name NVARCHAR(100) NOT NULL,
    Mid_name NVARCHAR(100) NULL,
    User_name NVARCHAR(100) NOT NULL
		CONSTRAINT U_user_name UNIQUE, 
    Password NVARCHAR(100) NOT NULL
		CONSTRAINT U_password UNIQUE, 
    Email NVARCHAR(100) NOT NULL
		CONSTRAINT CH_user_email CHECK (
				Email like '%@%'
		)
		CONSTRAINT U_email UNIQUE,
    Phone_number NVARCHAR(50) NULL,
    Profile_image_url NVARCHAR(200) NULL,
    Gender VARCHAR(6) NULL 
        CONSTRAINT CH_user_gender CHECK (
            Gender in('M', 'F', 'PNTA') -- PNTA - prefer not to answer 
        ),
    Last_access_date DATE NOT NULL
        CONSTRAINT CH_employee_lastaccess CHECK (
            Last_access_date BETWEEN '2020-01-01' AND GETDATE()
        ),
    Birth_date DATE NOT NULL
        CONSTRAINT CH_user_birthdate CHECK (
            Birth_date BETWEEN '1900-01-01' AND GETDATE()
        ),
    Creation_date DATE NOT NULL
        CONSTRAINT CH_user_creation_date CHECK (
            Creation_date BETWEEN '2020-01-01' AND GETDATE()
        ),
    User_location_id INT NOT NULL
        CONSTRAINT FK_user_location FOREIGN KEY REFERENCES User_locations (ID)
)
GO
----------GENRES-CAST-ETC-RELATED-TABLES---------------------------------------------------------------

CREATE TABLE Genres (
    ID BIGINT NOT NULL PRIMARY KEY,
    Genre_name NVARCHAR(100) NOT NULL
		CONSTRAINT U_genre_name UNIQUE, 
)
GO

CREATE TABLE Genre_preferences (
    ID INT NOT NULL PRIMARY KEY,
    User_id BIGINT NOT NULL
        CONSTRAINT FK_genre_pref_user FOREIGN KEY REFERENCES Users (ID),
    Genre_id BIGINT NOT NULL
        CONSTRAINT FK_genre_pref_genre FOREIGN KEY REFERENCES Genres (ID),
)
GO

CREATE TABLE Roles (
    ID BIGINT NOT NULL PRIMARY KEY,
    Role_name NVARCHAR(100) NOT NULL
		CONSTRAINT U_role_name UNIQUE, 
)   
GO

CREATE TABLE Cast (
    ID BIGINT NOT NULL PRIMARY KEY,
    First_name NVARCHAR(100) NOT NULL,
    Last_name NVARCHAR(100) NOT NULL,
    Mid_name NVARCHAR(100) NULL,
    Biography NVARCHAR(450) NULL,
    Birth_date DATE NOT NULL
        CONSTRAINT CH_cast_birthdate CHECK (
            Birth_date BETWEEN '1900-01-01' AND GETDATE()
        ),
    Gender VARCHAR(1) NOT NULL
        CONSTRAINT CH_cast_gender CHECK (
            Gender in ('M', 'F')
        )
)   
GO

CREATE TABLE Actors (
    ID BIGINT NOT NULL PRIMARY KEY,
    First_name NVARCHAR(100) NOT NULL,
    Last_name NVARCHAR(100) NOT NULL,
    Mid_name NVARCHAR(100) NULL,
    Biography NVARCHAR(450) NULL,
    Birth_date DATE NOT NULL
        CONSTRAINT CH_actor_birthdate CHECK (
            Birth_date BETWEEN '1900-01-01' AND GETDATE()
        ),
    Gender VARCHAR(1) NOT NULL
        CONSTRAINT CH_actor_gender CHECK (
            Gender in ('M', 'F')
        )
) 
GO

CREATE TABLE Subscription_plans (
    ID BIGINT NOT NULL PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL
		CONSTRAINT U_subscription_plan_name UNIQUE,
    Description NVARCHAR(200) NOT NULL,
    Price_month FLOAT NOT NULL
) 
GO

CREATE TABLE Users_subscription_plans (
    ID BIGINT NOT NULL PRIMARY KEY,
    Start_date DATE NOT NULL
        CONSTRAINT CH_supscription_startdate CHECK (
            Start_date BETWEEN '2020-01-01' AND GETDATE()
        ),
    End_date DATE NOT NULL
        CONSTRAINT CH_supscription_enddate CHECK (
            End_date BETWEEN '2020-01-01' AND '2150-01-01'
        ),
    User_id BIGINT NOT NULL
        CONSTRAINT FK_users_subscription_user FOREIGN KEY REFERENCES Users (ID),
    Subscription_plan_id BIGINT NOT NULL
        CONSTRAINT FK_users_subscription_plan FOREIGN KEY REFERENCES Subscription_plans (ID)
) 
GO
----------PAYMENT-TABLES--------------------------------------------------------------------------------
CREATE TABLE Payment_methods (
    ID BIGINT NOT NULL PRIMARY KEY, 
    Payment_method_description NVARCHAR(200) NOT NULL
)
GO

CREATE TABLE Payments (
    ID BIGINT NOT NULL PRIMARY KEY,
    Payment_date DATE NOT NULL
        CONSTRAINT CH_payment_date CHECK (
            Payment_date BETWEEN '2020-01-01' AND GETDATE() 
        ), 
    Paid_price FLOAT NOT NULL
		CONSTRAINT CH_paid_price CHECK (
			Paid_price > 0
		),   
    Card_number INT NOT NULL
		CONSTRAINT CH_card_number CHECK (
            LEN(Card_number) BETWEEN 13 AND 19 
        ), 
    User_id BIGINT NOT NULL
        CONSTRAINT FK_payments_user FOREIGN KEY REFERENCES Users (ID),
    Payment_method_id BIGINT NOT NULL
        CONSTRAINT FK_payments_method FOREIGN KEY REFERENCES Payment_methods (ID),
    User_subscription_plan_id BIGINT NOT NULL
        CONSTRAINT FK_payments_subscription_plan FOREIGN KEY REFERENCES Users_subscription_plans (ID)
) 
GO
----------LANGUAGES--------------------------------------------------------------------------------
CREATE TABLE Languages (
    ID BIGINT NOT NULL PRIMARY KEY,
    Language NVARCHAR(100) NOT NULL
		CONSTRAINT U_language UNIQUE
)
GO
----------MOVIE-RELATED-TABLES---------------------------------------------------------------------
CREATE TABLE Movies (
    ID BIGINT NOT NULL PRIMARY KEY,
    Production_year INT NOT NULL
		CONSTRAINT CH_movies_production_year CHECK (
			Production_year BETWEEN '1880' AND YEAR(GETDATE()) + 10
		),
    Duration_time INT NOT NULL -- IN MINUTES
		CONSTRAINT CH_movie_duration CHECK (
			Duration_time > 0
		),
    Age_restriction INT NOT NULL -- MINIMAL AGE
		CONSTRAINT CH_movies_age_restrictions CHECK (
			Age_restriction BETWEEN '0' AND '18'
		),
    Movie_image_url NVARCHAR(300) NOT NULL
)
GO

CREATE TABLE Movie_cast_roles (
    ID BIGINT NOT NULL PRIMARY KEY,
    Role_id BIGINT NOT NULL
        CONSTRAINT FK_cast_roles FOREIGN KEY REFERENCES Roles (ID),
    Cast_id BIGINT NOT NULL
        CONSTRAINT FK_movie_cast FOREIGN KEY REFERENCES Cast (ID),
    Movie_id BIGINT NOT NULL
        CONSTRAINT FK_cast_movies FOREIGN KEY REFERENCES Movies (ID)
) 
GO

CREATE TABLE Movie_actors (
    ID BIGINT NOT NULL PRIMARY KEY,
    Actor_id BIGINT NOT NULL
        CONSTRAINT FK_movie_actors FOREIGN KEY REFERENCES Actors (ID),
    Movie_id BIGINT NOT NULL
        CONSTRAINT FK_movie_actors_movies FOREIGN KEY REFERENCES Movies (ID)
)
GO

CREATE TABLE Movie_locations (
    ID BIGINT NOT NULL PRIMARY KEY,
    Location_id BIGINT NOT NULL
        CONSTRAINT FK_movies_locations FOREIGN KEY REFERENCES Locations (ID),
    Movie_id BIGINT NOT NULL
        CONSTRAINT FK_locations_movies FOREIGN KEY REFERENCES Movies (ID)
)
GO

CREATE TABLE Movie_restrictions (
    ID BIGINT NOT NULL PRIMARY KEY,
    Subscription_plan_id BIGINT NOT NULL
        CONSTRAINT FK_restrictions_subscr_plans FOREIGN KEY REFERENCES Subscription_plans (ID),
    Movie_id BIGINT NOT NULL
        CONSTRAINT FK_restrictions_movies FOREIGN KEY REFERENCES Movies (ID)
)
GO

CREATE TABLE Movie_ratings (
    ID BIGINT NOT NULL PRIMARY KEY,
    Rating FLOAT NOT NULL
		CONSTRAINT CH_movie_rating CHECK (
            Rating BETWEEN '0' AND '10'
        ),
    Rdate DATE NOT NULL
        CONSTRAINT CH_rating_date CHECK (
            Rdate BETWEEN '2020-01-01' AND GETDATE()
        ),
    User_id BIGINT NOT NULL
        CONSTRAINT FK_movies_rating_users FOREIGN KEY REFERENCES Users (ID),
    Movie_id BIGINT NOT NULL
        CONSTRAINT FK_movies_rating_movies FOREIGN KEY REFERENCES Movies (ID)
)
GO

CREATE TABLE Movies_watched (
    ID BIGINT NOT NULL PRIMARY KEY,
    Time_watched TIME NOT NULL,
    Date_watched DATE NOT NULL
        CONSTRAINT CH_watched_date CHECK (
            Date_watched BETWEEN '2020-01-01' AND GETDATE()
        ),
    User_id BIGINT NOT NULL
        CONSTRAINT FK_movies_watched_users FOREIGN KEY REFERENCES Users (ID),
    Movie_id BIGINT NOT NULL
        CONSTRAINT FK_movies_watched_movies FOREIGN KEY REFERENCES Movies (ID)
)
GO

CREATE TABLE User_reviews_movie (
    ID BIGINT NOT NULL PRIMARY KEY,
    Review_text NVARCHAR(700) NOT NULL,
    Creation_date DATE NOT NULL
        CONSTRAINT CH_creation_date CHECK (
            Creation_date BETWEEN '2020-01-01' AND GETDATE()
        ),
    User_id BIGINT NOT NULL
        CONSTRAINT FK_reviews_users FOREIGN KEY REFERENCES Users (ID),
    Movie_id BIGINT NOT NULL
        CONSTRAINT FK_reviews_movies FOREIGN KEY REFERENCES Movies (ID)
)
GO

CREATE TABLE Movie_genres (
    ID BIGINT NOT NULL PRIMARY KEY,
    Movie_id BIGINT NOT NULL
        CONSTRAINT FK_genres_movies FOREIGN KEY REFERENCES Movies (ID),
    Genre_id BIGINT NOT NULL
        CONSTRAINT FK_movies_genres FOREIGN KEY REFERENCES Genres (ID)
)
GO

CREATE TABLE Movies_production_countries (
    ID BIGINT NOT NULL PRIMARY KEY,
    Movie_id BIGINT NOT NULL
        CONSTRAINT FK_countries_movies FOREIGN KEY REFERENCES Movies (ID),
    Country_id BIGINT NOT NULL
        CONSTRAINT FK_movies_production_countries FOREIGN KEY REFERENCES Countries (ID)
)
GO

CREATE TABLE Movie_localizations (
    ID BIGINT NOT NULL PRIMARY KEY,
    Title NVARCHAR(100) NOT NULL,
    Description NVARCHAR(300) NOT NULL,
    Movie_id BIGINT NOT NULL
        CONSTRAINT FK_localizations_movies FOREIGN KEY REFERENCES Movies (ID),
    Language_id BIGINT NOT NULL
        CONSTRAINT FK_movie_local_languages FOREIGN KEY REFERENCES Languages (ID)
)
GO

CREATE TABLE Movies_dub_languages (
    ID BIGINT NOT NULL PRIMARY KEY,
    Language_id BIGINT NOT NULL
        CONSTRAINT FK_movies_dub_languages FOREIGN KEY REFERENCES Languages (ID),
    Movie_id BIGINT NOT NULL
        CONSTRAINT FK_dub_languages_movies FOREIGN KEY REFERENCES Movies (ID)
)
GO

CREATE TABLE Movies_sub_languages (
    ID BIGINT NOT NULL PRIMARY KEY,
    Language_id BIGINT NOT NULL
        CONSTRAINT FK_movies_sub_languages FOREIGN KEY REFERENCES Languages (ID),
    Movie_id BIGINT NOT NULL
        CONSTRAINT FK_sub_languages_movies FOREIGN KEY REFERENCES Movies (ID)
)
GO
----------TVSHOW-RELATED-TABLES---------------------------------------------------------------------
CREATE TABLE TVshows (
    ID BIGINT NOT NULL PRIMARY KEY,
    Age_restriction INT NOT NULL
		CONSTRAINT CH_tvshow_age_restrictions CHECK (
			Age_restriction BETWEEN '0' AND '18'
		), 
    Production_year INT NOT NULL
		CONSTRAINT CH_tvshow_production_year CHECK (
			Production_year BETWEEN '1880' AND YEAR(GETDATE()) + 10
		),
    Seasons_amount INT NOT NULL
		CONSTRAINT CH_tvseason_amount CHECK (
			Seasons_amount >= 0
		), 
    Episodes_amount INT NOT NULL
		CONSTRAINT CH_tvepisode_amount CHECK (
			Episodes_amount >= 0
		),
    TVshow_image_url NVARCHAR(300) NOT NULL
)
GO

CREATE TABLE TV_seasons (
    ID BIGINT NOT NULL PRIMARY KEY,
	Production_year INT NOT NULL
		CONSTRAINT CH_tv_seasons_production_year CHECK (
			Production_year BETWEEN '1880' AND YEAR(GETDATE()) + 10
		),
    Episodes_amount INT NOT NULL
		CONSTRAINT CH_tv_episode_amount CHECK (
			Episodes_amount >= 0
		),
    TVshow_season_image_url NVARCHAR(300) NOT NULL,
    TVshow_id BIGINT NOT NULL
        CONSTRAINT FK_tv_seasons_shows FOREIGN KEY REFERENCES TVshows (ID)
)
GO

CREATE TABLE TV_episodes (
    ID BIGINT NOT NULL PRIMARY KEY,
    Title NVARCHAR(100) NOT NULL,
    Description NVARCHAR(300) NOT NULL,
    Production_date DATE NOT NULL
        CONSTRAINT CH_tv_episodes_production_date CHECK (
            Production_date BETWEEN '1880-01-01' AND GETDATE()
        ), 
    Duration INT NOT NULL
		CONSTRAINT CH_tv_episode_duration CHECK (
			Duration > 0
		),
    TVshow_id BIGINT NOT NULL
        CONSTRAINT FK_tv_episodes_shows FOREIGN KEY REFERENCES TVshows (ID),
    TV_seasons_id BIGINT NOT NULL
        CONSTRAINT FK_tv_episodes_seasons FOREIGN KEY REFERENCES TV_seasons (ID),
)
GO 

CREATE TABLE Episode_locations (
    ID BIGINT NOT NULL PRIMARY KEY,
    Location_id BIGINT NOT NULL
        CONSTRAINT FK_episodes_locations FOREIGN KEY REFERENCES Locations (ID),
    TV_episode_id BIGINT NOT NULL
        CONSTRAINT FK_locations_episodes FOREIGN KEY REFERENCES TV_episodes (ID)
)
GO

CREATE TABLE TVshow_ratings (
    ID BIGINT NOT NULL PRIMARY KEY,
    Rating FLOAT NOT NULL
		CONSTRAINT CH_tv_show_rating CHECK (
            Rating BETWEEN '0' AND '10'
        ),
    Rdate DATE NOT NULL
        CONSTRAINT CH_tvshow_rating_date CHECK (
            Rdate BETWEEN '2020-01-01' AND GETDATE()
        ),
    User_id BIGINT NOT NULL
        CONSTRAINT FK_tvshow_rating_users FOREIGN KEY REFERENCES Users (ID),
    TVshow_id BIGINT NOT NULL
        CONSTRAINT FK_ratings_tvshow FOREIGN KEY REFERENCES TVshows (ID)
)
GO

CREATE TABLE TV_season_ratings (
    ID BIGINT NOT NULL PRIMARY KEY,
    Rating FLOAT NOT NULL
		CONSTRAINT CH_tv_season_rating CHECK (
            Rating BETWEEN '0' AND '10'
        ),
    Rdate DATE NOT NULL
        CONSTRAINT CH_tv_season_rating_date CHECK (
            Rdate BETWEEN '2020-01-01' AND GETDATE()
        ),
    User_id BIGINT NOT NULL
        CONSTRAINT FK_tv_season_rating_users FOREIGN KEY REFERENCES Users (ID),
    TV_season_id BIGINT NOT NULL
        CONSTRAINT FK_ratings_tvshow_season FOREIGN KEY REFERENCES TV_seasons (ID)
)
GO

CREATE TABLE TV_episode_ratings (
    ID BIGINT NOT NULL PRIMARY KEY,
    Rating FLOAT NOT NULL
		CONSTRAINT CH_tv_episode_rating CHECK (
            Rating BETWEEN '0' AND '10'
        ),
    Rdate DATE NOT NULL
        CONSTRAINT CH_tv_episode_rating_date CHECK (
            Rdate BETWEEN '2020-01-01' AND GETDATE()
        ),
    User_id BIGINT NOT NULL
        CONSTRAINT FK_episode_rating_users FOREIGN KEY REFERENCES Users (ID),
    TV_episode_id BIGINT NOT NULL
        CONSTRAINT FK_ratings_episode FOREIGN KEY REFERENCES TV_episodes (ID)
)
GO

CREATE TABLE TV_show_genres (
    ID BIGINT NOT NULL PRIMARY KEY,
    TV_show_id BIGINT NOT NULL
        CONSTRAINT FK_genres_tvshow FOREIGN KEY REFERENCES TVshows (ID),
    Genre_id BIGINT NOT NULL
        CONSTRAINT FK_tv_show_genres FOREIGN KEY REFERENCES Genres (ID)
)
GO

CREATE TABLE TVshow_user_reviews (
    ID BIGINT NOT NULL PRIMARY KEY,
    Review_text NVARCHAR(600) NOT NULL,
    Creation_date DATE NOT NULL
        CONSTRAINT CH_tvshow_review_creation_date CHECK (
            Creation_date BETWEEN '2020-01-01' AND GETDATE()
        ),
    User_id BIGINT NOT NULL
        CONSTRAINT FK_tv_show_reviews_users FOREIGN KEY REFERENCES Users (ID),
    TVshow_id BIGINT NOT NULL
        CONSTRAINT FK_reviews_tv_show FOREIGN KEY REFERENCES TVshows (ID)
)
GO

CREATE TABLE TV_episode_user_reviews (
    ID BIGINT NOT NULL PRIMARY KEY,
    Review_text NVARCHAR(600) NOT NULL,
    Creation_date DATE NOT NULL
        CONSTRAINT CH_tv_episode_review_creation_date CHECK (
            Creation_date BETWEEN '2020-01-01' AND GETDATE()
        ),
    User_id BIGINT NOT NULL
        CONSTRAINT FK_tv_episode_reviews_users FOREIGN KEY REFERENCES Users (ID),
    TV_episode_id BIGINT NOT NULL
        CONSTRAINT FK_reviews_tv_episode FOREIGN KEY REFERENCES TV_episodes (ID)
)
GO

CREATE TABLE TVshow_production_countries (
    ID BIGINT NOT NULL PRIMARY KEY,
    TVshow_id BIGINT NOT NULL
        CONSTRAINT FK_countries_tvshows FOREIGN KEY REFERENCES TVshows (ID),
    Country_id BIGINT NOT NULL
        CONSTRAINT FK_tvshow_production_countries FOREIGN KEY REFERENCES Countries (ID)
)
GO

CREATE TABLE TV_episodes_actors (
    ID BIGINT NOT NULL PRIMARY KEY,
    Actor_id BIGINT NOT NULL
        CONSTRAINT FK_tv_episode_actors FOREIGN KEY REFERENCES Actors (ID),
    TV_episode_id BIGINT NOT NULL
        CONSTRAINT FK_actors_tv_episode FOREIGN KEY REFERENCES TV_episodes (ID)
)
GO

CREATE TABLE TV_episode_cast_roles (
    ID BIGINT NOT NULL PRIMARY KEY,
    Role_id BIGINT NOT NULL
        CONSTRAINT FK_tv_episode_cast_roles FOREIGN KEY REFERENCES Roles (ID),
    Cast_id BIGINT NOT NULL
        CONSTRAINT FK_tv_episode_cast FOREIGN KEY REFERENCES Cast (ID),
    TV_episode_id BIGINT NOT NULL
        CONSTRAINT FK_cast_tv_episode FOREIGN KEY REFERENCES TV_episodes (ID)
) 
GO

CREATE TABLE TVshow_restrictions (
    ID BIGINT NOT NULL PRIMARY KEY,
    Subscription_plan_id BIGINT NOT NULL
        CONSTRAINT FK_tvshow_restrictions_subscr_plans FOREIGN KEY REFERENCES Subscription_plans (ID),
    TVshow_id BIGINT NOT NULL
        CONSTRAINT FK_restrictions_tvshow FOREIGN KEY REFERENCES TVshows (ID)
)
GO

CREATE TABLE TVshows_watched (
    ID BIGINT NOT NULL PRIMARY KEY,
    Time_watched TIME NOT NULL,
    Date_watched DATE NOT NULL
        CONSTRAINT CH_tvshow_watched_date CHECK (
            Date_watched BETWEEN '2020-01-01' AND GETDATE()
        ),
    User_id BIGINT NOT NULL
        CONSTRAINT FK_tvshows_watched_users FOREIGN KEY REFERENCES Users (ID),
    TVshow_id BIGINT NOT NULL
        CONSTRAINT FK_tvshows_watched_tvshows FOREIGN KEY REFERENCES TVshows (ID)
)
GO

CREATE TABLE Last_tv_episode_watched (
    ID BIGINT NOT NULL PRIMARY KEY,
    Time_watched TIME NOT NULL,
    Date_watched DATE NOT NULL
        CONSTRAINT CH_last_tv_episode_watched_date CHECK (
            Date_watched BETWEEN '2020-01-01' AND GETDATE()
        ),
    Stopped_at_time INT NOT NULL, 
    User_id BIGINT NOT NULL
        CONSTRAINT FK_last_tv_episode_watched_users FOREIGN KEY REFERENCES Users (ID),
    TVshow_id BIGINT NOT NULL
        CONSTRAINT FK_last_tv_episode_watched_tvshows FOREIGN KEY REFERENCES TVshows (ID),
    TV_season_id BIGINT NOT NULL
        CONSTRAINT FK_last_tv_episode_watched_seasons FOREIGN KEY REFERENCES TV_seasons (ID),
    TV_episode_id BIGINT NOT NULL
        CONSTRAINT FK_last_tv_episode_watched_episodes FOREIGN KEY REFERENCES TV_episodes (ID)
)
GO

CREATE TABLE TVshow_localizations (
    ID BIGINT NOT NULL PRIMARY KEY,
    Title NVARCHAR(100) NOT NULL,
    Description NVARCHAR(300) NOT NULL,
    TVshow_id BIGINT NOT NULL
        CONSTRAINT FK_localizations_tvshows FOREIGN KEY REFERENCES TVshows (ID),
    Language_id BIGINT NOT NULL
        CONSTRAINT FK_tvshows_local_languages FOREIGN KEY REFERENCES Languages (ID)
)
GO

CREATE TABLE TV_season_localizations (
    ID BIGINT NOT NULL PRIMARY KEY,
    Title NVARCHAR(100) NOT NULL,
    Description NVARCHAR(300) NOT NULL,
    TV_season_id BIGINT NOT NULL
        CONSTRAINT FK_localizations_tv_seasons FOREIGN KEY REFERENCES TV_seasons (ID),
    Language_id BIGINT NOT NULL
        CONSTRAINT FK_tv_season_local_languages FOREIGN KEY REFERENCES Languages (ID)
)
GO

CREATE TABLE TVshow_dub_languages (
    ID BIGINT NOT NULL PRIMARY KEY,
    Language_id BIGINT NOT NULL
        CONSTRAINT FK_tvshow_dub_languages FOREIGN KEY REFERENCES Languages (ID),
    TVshow_id BIGINT NOT NULL
        CONSTRAINT FK_dub_languages_tvshow FOREIGN KEY REFERENCES TVshows (ID)
)
GO

CREATE TABLE TVshow_sub_languages (
    ID BIGINT NOT NULL PRIMARY KEY,
    Language_id BIGINT NOT NULL
        CONSTRAINT FK_tvshow_sub_languages FOREIGN KEY REFERENCES Languages (ID),
    TVshow_id BIGINT NOT NULL
        CONSTRAINT FK_sub_languages_tvshow FOREIGN KEY REFERENCES TVshows (ID)
)
GO
----------TVSHOW-AND-MOVIE-RELATED-TABLES---------------------------------------------------------------------
CREATE TABLE For_later (
	ID BIGINT NOT NULL PRIMARY KEY,
	User_id BIGINT NOT NULL
        CONSTRAINT FK_for_later_by_user FOREIGN KEY REFERENCES Users (ID),
	TVshow_id BIGINT NULL
        CONSTRAINT FK_for_later_tvshows FOREIGN KEY REFERENCES TVshows (ID),
	Movie_id BIGINT NULL
        CONSTRAINT FK_for_later_movies FOREIGN KEY REFERENCES Movies (ID),
	CHECK((TVshow_id IS NULL AND Movie_id IS NOT NULL)
		OR (TVshow_id IS NOT NULL AND Movie_id IS NULL))
)
GO

CREATE TABLE Dropped (
	ID BIGINT NOT NULL PRIMARY KEY,
	User_id BIGINT NOT NULL
        CONSTRAINT FK_dropped_by_user FOREIGN KEY REFERENCES Users (ID),
	TVshow_id BIGINT NULL
        CONSTRAINT FK_dropped_tvshows FOREIGN KEY REFERENCES TVshows (ID),
	Movie_id BIGINT NULL
        CONSTRAINT FK_dropped_movies FOREIGN KEY REFERENCES Movies (ID),
	CHECK((TVshow_id IS NULL AND Movie_id IS NOT NULL)
		OR (TVshow_id IS NOT NULL AND Movie_id IS NULL))
)
GO

CREATE TABLE Liked (
	ID BIGINT NOT NULL PRIMARY KEY,
	User_id BIGINT NOT NULL
        CONSTRAINT FK_liked_by_user FOREIGN KEY REFERENCES Users (ID),
	TVshow_id BIGINT NULL
        CONSTRAINT FK_liked_tvshows FOREIGN KEY REFERENCES TVshows (ID),
	Movie_id BIGINT NULL
        CONSTRAINT FK_liked_movies FOREIGN KEY REFERENCES Movies (ID),
	CHECK((TVshow_id IS NULL AND Movie_id IS NOT NULL)
		OR (TVshow_id IS NOT NULL AND Movie_id IS NULL))
)
GO

