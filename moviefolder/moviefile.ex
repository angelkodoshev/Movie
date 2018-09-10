defmodule MovieDatabase do
use GenServer

Interface

def start() do
GenServer.start(__MODULE__,[],name: __MODULE__)
end

def add(new_movie) do
GenServer.cast(__MODULE__,{:add,new_movie})
end

def remove(id) do
GenServer.cast(__MODULE__,{:remove,id})
end

def by_id(id) do
GenServer.call(__MODULE__,{:by_id,id})
end

def by_genre(genre) do
GenServer.call(__MODULE__,{:genre,genre})
end

def by_actor(actor) do
GenServer.call(__MODULE__,{:actor,actor})
end

def by_year(year) do
GenServer.call(__MODULE__,{newer_or_older,year})
end


Internal


def init(movie) do
{:ok,movie}
end

def handle_cast({:add,new_movie},listofmovies) do
{:noreply,[new_movie | listofmovies]}
end

def handle_cast({:remove,id},listofmovies) do
{:noreply,[id | listofmovies]}
end

def handle_call({by_id,id},_from,listofmovies) do
{:reply,Enum.find(listofmovies, fn movie-> id == movie.id end),listofmovies}
end

def handle_call({:genre,genre},listofmovie) do
{:reply,Enum.filter(listofmovies,fn movie->genre == movie.genre end),listofmovies}
end

def handle_call({:actor,actor},listofmovies) do
{:reply,Enum.filter(listofmovies, fn movie->actor==movie.actor end),listofmovies}
end

def handle_call({:newer_or_older,year},listofmovies) do
{:reply,Enum.filter(listofmovies, fn movie->year<movie.year or year>movie.year end),listofmovies}
end






end
