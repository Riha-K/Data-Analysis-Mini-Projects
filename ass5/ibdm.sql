use ibdm;
select * from ibdm.imdb_movies;

select director_name as top10director, avg(imdb_score) as imdb_score
from ibdm.imdb_movies
group by top10director 
order by  imdb_score desc
limit 10;

select distinct genres, count(genres) as genresCount
from ibdm.imdb_movies
group by genres
order by genresCount desc
limit 10;

select actor_1_name critic_favorite, avg(num_critic_for_reviews) as criticReviewCount                     
from ibdm.imdb_movies
group by critic_favorite
order by criticReviewCount desc 
limit 1;                                                                                                   


select actor_1_name audience_favorite, avg(num_user_for_reviews) as UserReviewCount
from ibdm.imdb_movies
group by audience_favorite
order by UserReviewCount desc 
limit 1;                                                                                                      
