ps:
	docker-compose ps

up:
	docker-compose up -d --remove-orphans

upb:
	docker-compose up -d --build --remove-orphans

down:
	docker-compose down

stop:
	docker-compose stop

migrate:
	docker-compose exec php php artisan migrate

fresh:
	docker-compose exec php php artisan migrate:fresh

laravel-install:
	docker-compose exec php composer create-project --prefer-dist laravel/laravel .

create-project:
	mkdir -p src
	@make upb
	@make laravel-install
	docker-compose exec php php artisan key:generate
	docker-compose exec php php artisan storage:link

setup:
	@make upb
	docker-compose exec php composer install --optimize-autoloader
	docker-compose exec php npm install
	docker-compose exec php cp .env.example .env
	docker-compose exec php php artisan key:generate
	docker-compose exec php php artisan storage:link

#make rs name=php
rs:
	docker-compose restart $(name)
nrs:
	docker-compose restart nginx

#make exec name=php
exec:
	docker-compose exec $(name) /bin/bash

php:
	docker-compose exec php /bin/bash

logs:
	docker-compose logs $(name)

