themes = [
  { name_ru: "Центр города", name_en: "City center" },
  { name_ru: "Семейный досуг", name_en: "Family leisure" },
  { name_ru: "Крупные комплексы", name_en: "Large complexes" }
]

theme_records = themes.each_with_object({}) do |attrs, records|
  Theme.find_or_create_by!(name_ru: attrs[:name_ru]) do |theme|
    theme.name_en = attrs[:name_en]
  end.tap { |theme| records[attrs[:name_ru]] = theme }
end

mall_items = [
  {
    theme: "Центр города",
    name_ru: "ТРЦ Галерея",
    name_en: "Galeria Mall",
    address_ru: "Лиговский проспект, 30А",
    address_en: "30A Ligovsky Avenue",
    description_ru: "Крупный торгово-развлекательный комплекс рядом с Московским вокзалом, ориентированный на городские покупки и быстрый досуг.",
    description_en: "A major shopping and entertainment center near Moskovsky railway station, focused on city shopping and quick leisure.",
    image_url: "https://images.unsplash.com/photo-1519567770579-c2fc5436bcf9?auto=format&fit=crop&w=1200&q=80"
  },
  {
    theme: "Центр города",
    name_ru: "Невский Центр",
    name_en: "Nevsky Centre",
    address_ru: "Невский проспект, 114-116",
    address_en: "114-116 Nevsky Avenue",
    description_ru: "Торговый центр на главной магистрали города с акцентом на доступность, магазины повседневного спроса и ресторанную зону.",
    description_en: "A shopping center on the city's main avenue with strong accessibility, everyday retail and a restaurant area.",
    image_url: "https://images.unsplash.com/photo-1508009603885-50cf7c579365?auto=format&fit=crop&w=1200&q=80"
  },
  {
    theme: "Центр города",
    name_ru: "ТЦ Владимирский Пассаж",
    name_en: "Vladimirsky Passage",
    address_ru: "Владимирский проспект, 19",
    address_en: "19 Vladimirsky Avenue",
    description_ru: "Компактный торговый центр в историческом центре, удобный для коротких покупок и встреч в центральной части города.",
    description_en: "A compact mall in the historic center, convenient for quick shopping and meetings in the central district.",
    image_url: "https://images.unsplash.com/photo-1555529669-e69e7aa0ba9a?auto=format&fit=crop&w=1200&q=80"
  },
  {
    theme: "Семейный досуг",
    name_ru: "ТРЦ Охта Молл",
    name_en: "Okhta Mall",
    address_ru: "Брантовская дорога, 3",
    address_en: "3 Brantovskaya Road",
    description_ru: "Современный комплекс с кинотеатром, детскими зонами, фудкортом и удобными сценариями семейного посещения.",
    description_en: "A modern complex with a cinema, kids' areas, food court and comfortable family visit scenarios.",
    image_url: "https://images.unsplash.com/photo-1518005020951-eccb494ad742?auto=format&fit=crop&w=1200&q=80"
  },
  {
    theme: "Семейный досуг",
    name_ru: "ТРК Питерлэнд",
    name_en: "Piterland Mall",
    address_ru: "Приморский проспект, 72",
    address_en: "72 Primorsky Avenue",
    description_ru: "Развлекательный комплекс у Финского залива, известный аквапарком, кинотеатром и зонами отдыха для семейной аудитории.",
    description_en: "An entertainment complex by the Gulf of Finland, known for its water park, cinema and family recreation areas.",
    image_url: "https://images.unsplash.com/photo-1533634971108-7c061b0ac5f8?auto=format&fit=crop&w=1200&q=80"
  },
  {
    theme: "Семейный досуг",
    name_ru: "ТРК Гранд Каньон",
    name_en: "Grand Canyon Mall",
    address_ru: "проспект Энгельса, 154",
    address_en: "154 Engels Avenue",
    description_ru: "Северный торгово-развлекательный комплекс с магазинами, образовательными и детскими пространствами.",
    description_en: "A northern shopping and entertainment complex with retail, educational and children's spaces.",
    image_url: "https://images.unsplash.com/photo-1519999482648-25049ddd37b1?auto=format&fit=crop&w=1200&q=80"
  },
  {
    theme: "Крупные комплексы",
    name_ru: "ТРК Европолис",
    name_en: "Europolis Mall",
    address_ru: "Полюстровский проспект, 84",
    address_en: "84 Polyustrovsky Avenue",
    description_ru: "Большой комплекс с широким набором магазинов, ресторанов и сервисов, рассчитанный на длительный визит.",
    description_en: "A large complex with a broad set of stores, restaurants and services designed for a longer visit.",
    image_url: "https://images.unsplash.com/photo-1577415124269-fc1140a69e91?auto=format&fit=crop&w=1200&q=80"
  },
  {
    theme: "Крупные комплексы",
    name_ru: "ТРК Лето",
    name_en: "Leto Mall",
    address_ru: "Пулковское шоссе, 25",
    address_en: "25 Pulkovskoe Highway",
    description_ru: "Крупный торговый центр на юге города, удобный для автомобильного посещения и покупок выходного дня.",
    description_en: "A large mall in the south of the city, convenient for car access and weekend shopping.",
    image_url: "https://images.unsplash.com/photo-1567449303078-57ad995bd17c?auto=format&fit=crop&w=1200&q=80"
  },
  {
    theme: "Крупные комплексы",
    name_ru: "ТРК Радуга",
    name_en: "Raduga Mall",
    address_ru: "проспект Космонавтов, 14",
    address_en: "14 Kosmonavtov Avenue",
    description_ru: "Масштабный комплекс в Московском районе с торговыми галереями, развлечениями и большим фудкортом.",
    description_en: "A large complex in Moskovsky district with shopping galleries, entertainment and a large food court.",
    image_url: "https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?auto=format&fit=crop&w=1200&q=80"
  },
  {
    theme: "Крупные комплексы",
    name_ru: "ТРК Сити Молл",
    name_en: "City Mall",
    address_ru: "Коломяжский проспект, 17",
    address_en: "17 Kolomyazhsky Avenue",
    description_ru: "Крупная городская площадка у метро Пионерская с магазинами, кинотеатром и повседневными сервисами.",
    description_en: "A large urban venue near Pionerskaya metro station with shops, a cinema and everyday services.",
    image_url: "https://images.unsplash.com/photo-1519501025264-65ba15a82390?auto=format&fit=crop&w=1200&q=80"
  }
]

mall_items.each do |attrs|
  theme = theme_records.fetch(attrs[:theme])
  MallItem.find_or_initialize_by(theme: theme, name_ru: attrs[:name_ru]).tap do |mall|
    mall.name_en = attrs[:name_en]
    mall.address_ru = attrs[:address_ru]
    mall.address_en = attrs[:address_en]
    mall.description_ru = attrs[:description_ru]
    mall.description_en = attrs[:description_en]
    mall.image_url = attrs[:image_url]
    mall.save!
  end
end

User.find_or_create_by!(email: "student@example.com") do |user|
  user.password = "password123"
  user.password_confirmation = "password123"
end

puts "Seeded #{Theme.count} themes and #{MallItem.count} mall items."
