# Очистка старых данных
Value.delete_all if defined?(Value)
Image.delete_all
Theme.delete_all
User.delete_all

# Сброс последовательностей ID
Image.reset_pk_sequence
Theme.reset_pk_sequence
User.reset_pk_sequence
Value.reset_pk_sequence if defined?(Value)

# Темы
themes = Theme.create!([
  { name: "Японские спорткары" },     # Toyota, Nissan, Honda, Mazda
  { name: "Немецкие автомобили" },    # BMW, Mercedes, Porsche, Audi
  { name: "Американские маслкары" },  # Mustang, Corvette
  { name: "Итальянские суперспорт" }, # Ferrari, Lamborghini
  { name: "Премиум и гиперкары" }     # Bugatti, Aston Martin, Lexus
])

# Изображения
Image.create!([
  {name: 'Nissan Silvia', file: 'nissan_silvia.jpg', theme: themes[0]},
  {name: 'Toyota Supra', file: 'toyota_supra.jpg', theme: themes[0]},
  {name: 'Honda NSX', file: 'honda_nsx.jpg', theme: themes[0]},
  {name: 'Mazda RX-7', file: 'mazda_rx7.jpg', theme: themes[0]},

  {name: 'BMW M3 E46', file: 'bmw_m3_e46.jpg', theme: themes[1]},
  {name: 'Mercedes SLS AMG', file: 'mercedes_sls.jpg', theme: themes[1]},
  {name: 'Porsche 911', file: 'porsche_911.jpg', theme: themes[1]},
  {name: 'Audi R8', file: 'audi_r8.jpg', theme: themes[1]},

  {name: 'Ford Mustang GT500', file: 'mustang_gt500.jpg', theme: themes[2]},
  {name: 'Chevrolet Corvette C7', file: 'corvette_c7.jpg', theme: themes[2]},

  {name: 'Ferrari F40', file: 'ferrari_f40.jpg', theme: themes[3]},
  {name: 'Lamborghini Aventador', file: 'lamborghini_aventador.jpg', theme: themes[3]},

  {name: 'Bugatti Veyron', file: 'bugatti_veyron.jpg', theme: themes[4]},
  {name: 'Lexus LFA', file: 'lexus_lfa.jpg', theme: themes[4]},
  {name: 'Aston Martin DB11', file: 'aston_martin_db11.jpg', theme: themes[4]}
])

user = User.create!(
  name: "Example User",
  email: "exp@bk.ru",
  password: "123123",
  password_confirmation: "123123"
)

# Пример оценки
Value.create!(
  user: user,
  image: Image.first,
  value: 5
)