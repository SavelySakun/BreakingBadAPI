##  О приложении
Приложение для фанатов вселенной "Во все тяжкие", основанное на одноимённом API. Загружает информацию из API, сохраняет её в CoreData.

**Функции:**
- Загружает из API всю основную информацию по персонажам.
- Сохраняет данные по персонажам в CoreData (т.е. обращение к API происходит 1 раз, далее приложение использует только CoreData).
- На экране профиля персонажа можно ознакомиться с основной информацией о персонаже, увидеть его знаменитые цитаты.
- Цитаты можно сохранять в избранное (они появляются на отдельном экране "избранное"). Возможно удаление цитат из избранного.

**Стек используемых технологий:**
- UIKit, без использования Storyboard.
— CoreData.
- Работа с API [Breaking Bad](https://breakingbadapi.com/).
- Pod: UIImageViewAlignedSwift для выравнивания изображения внутри imageView.
- Архитектура MVC.

##  To-do list
- [х] Необходимо починить auto layout для горизонтального режима и маленьких экранов.
- [x] Добавить сохранение всех данных с API в Core Data. Сохранение в Favorites.
- [x] Починить мелкие UI баги.
- [x] Добавить иконку приложения.
- [x] Отрефакторить код, сделать его более читаемым и понятным.

##  Скриншоты
![Screens](https://user-images.githubusercontent.com/63949254/94390907-8044fd00-016d-11eb-887d-1d1b3bc43b2d.jpg)
