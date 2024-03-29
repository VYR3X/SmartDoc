
# SmartDoc 
Данное мобильное приложения создано в качестве моего pet project.
С помощью данного приложения можно записаться на прием к врачу

## Оглавление

1. [Интерфейс приложения](#Интерфейс-приложения)
   - [Главный экран](#Главный-экран)
   - [Календарь](#Календарь)
   - [Список доступный врачей для записи](#Список-доступный-врачей-для-записи)
   - [Расписание врача](#Расписание-врача)
   - [Вывод ошибок при записи](#Вывод-ошибок-при-записи)
   - [История записи](#История-записи)
2. [Архитектура приложения](#Архитектура-приложения)
3. [Хранение данных](#Хранение-данных)
4. [UI](#UI)
5. [Работа с сетью](#Работа-с-сетью)

# Интерфейс приложения 

Ниже представлены основные экраны приложения на которых продемонстирован весь сцений записи к врачу 

## Главный экран

<img src="/screenshots/mainScreen.png" width="22%">

На данном экране пользователю доступны следующие функции:

- Просмотреть новости 
- Выбрать специалиста для записи 
- Выбрать поликлинику 
- Проверить данный профиля пользователя
- Записаться на прием 
- Посмотреть историю записей

## Календарь   
<img src="/screenshots/calendar.png" width="22%">


## Список доступный врачей для записи 
<img src="/screenshots/doctorList.png" width="22%">

- На данном экране пользователь выбирает конкретного специалиста к которому есть запись на выбранный день 

## Расписание врача 
<img src="/screenshots/sheduler.png" width="22%">

- В конце прохождения сценария записи к врачу, пользователю отображается экран с выбором времени для записи к специалисту

## Вывод ошибок при записи 

<img src="/screenshots/alerts.png" width="50%">

- Если запись возможная на выбранное время, то отображается алерт об успешной записи. Пользователь может либо повторить запись к другому специалисту в выбранной поликлинике или нажать продолжить и попасть на главный экран 
- Если  запись невозможна на выбранное время то  пользователю будет предоставлена возможность выбрать другое время 

## История записи 

<img src="/screenshots/history.png" width="50%">

- Пользователь может увидеть всю историю своих записей на прием к врачам, или удалить талон  

# Архитектура приложения 

- VIPER 

# Хранение данных 

- Для сохранения информации о посещении врачей в мобильном приложении использовалась CoreData 

# UI 

- Интерфейс приложения реализован программно без использования storyboard и xib файлов 
- В качестве UI фреймворка использовался UIKit 

# Работа с сетью 

- Для работы с сетью использовалась URLSession 

