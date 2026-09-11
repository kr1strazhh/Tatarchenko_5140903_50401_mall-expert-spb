
# MallExpert SPb

Курсовой проект по дисциплине «Методики разработки современных WEB-приложений».

Автор: **Татарченко Андрей Александрович**

## Суть проекта

MallExpert SPb — Rails-приложение для экспертной оценки торговых центров Санкт-Петербурга. Пользователь регистрируется, выбирает категорию ТЦ, получает первую неоцененную карточку, ставит оценку плавным ползунком `1..100`, оставляет комментарий и может выгрузить свои оценки в CSV.

Проект сделан по требованиям из `promt2.txt`:

- Ruby on Rails 8 + PostgreSQL;
- кастомная авторизация через `has_secure_password` и `session[:user_id]`;
- модели `User`, `Theme`, `MallItem`, `Evaluation`;
- API `GET /api/v1/malls` и `POST /api/v1/malls`;
- локализация RU/EN через `scope "(:locale)"`;
- профиль пользователя и экспорт `my_evaluations.csv`;
- отчет в LaTeX.

## Быстрый запуск

```bash
cd /Users/doodels/.openclaw/workspace/projects/fooddecision-course
cp .env.example .env
bundle install
bin/rails db:create db:migrate db:seed
bin/rails s
```

Открыть:

- `http://localhost:3000/ru`
- `http://localhost:3000/en`

Демо-пользователь после `db:seed`:

- email: `student@example.com`
- password: `password123`

## Docker

```bash
docker build -t mall-expert-course .
docker run --rm -p 3000:3000 \
  -e RAILS_ENV=development \
  -e POSTGRES_HOST=host.docker.internal \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_PASSWORD=postgres \
  -e POSTGRES_DB=mall_expert_course_development \
  mall-expert-course \
  ./bin/rails server -b 0.0.0.0 -p 3000
```

## Тесты

```bash
bin/rails test
```

Покрыты:

- валидация оценки `1..100`;
- уникальность пары `user_id + mall_item_id`;
- расчет средней оценки;
- CSV-экспорт;
- вход пользователя, доступ к рабочей области и API-сценарий.

## Документация

- отчет Markdown/HTML для проверки: `report/README_REPORT.md`, `report/README_REPORT.html`;
- LaTeX-исходник отчета: `report/mall_expert_report.tex`;
- итоговый PDF-отчет: `report/mall_expert_report.pdf`;
- скриншоты и схемы: `screens/`.
