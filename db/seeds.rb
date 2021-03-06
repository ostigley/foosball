# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

players = Player.create([{ name: 'Gabriella Luettgen', email: 'lillie_mertz@lesch.org', uid: 'https://avatars0.githubusercontent.com/u/10747958?v=3&s=460', provider: 'github'}, { name: 'Sonny Moore', email: 'rolando@ziemann.name', uid: 'https://avatars0.githubusercontent.com/u/10747958?v=3&s=460', provider: 'github'}, { name: 'Emmet Flatley', email: 'garett.littel@hyatt.net', uid: 'https://avatars0.githubusercontent.com/u/10747958?v=3&s=460', provider: 'github'}, { name: 'Delphia Bernier', email: 'mae@corkery.org', uid: 'https://avatars0.githubusercontent.com/u/10747958?v=3&s=460', provider: 'github'}, { name: 'Reanna Brekke', email: 'ena_runte@mcglynn.co', uid: 'https://avatars0.githubusercontent.com/u/10747958?v=3&s=460', provider: 'github'}, { name: 'Keshaun Smitham', email: 'richie@baileypollich.org', uid: 'https://avatars0.githubusercontent.com/u/10747958?v=3&s=460', provider: 'github'}, { name: 'Maude Welch Sr.', email: 'gustave_pouros@zieme.com', uid: 'https://avatars0.githubusercontent.com/u/10747958?v=3&s=460', provider: 'github'}, { name: 'Grover Tremblay', email: 'marguerite_zieme@reichel.com', uid: 'https://avatars0.githubusercontent.com/u/10747958?v=3&s=460', provider: 'github'}, { name: 'Tyra Doyle', email: 'deangelo@kulas.com', uid: 'https://avatars0.githubusercontent.com/u/10747958?v=3&s=460', provider: 'github'}, { name: 'Nikki Lesch', email: 'juwan@koelpin.org', uid: 'https://avatars0.githubusercontent.com/u/10747958?v=3&s=460', provider: 'github' }])

teams = Team.create([{ player_ids: [1, 2] }, { player_ids: [2, 3] }, { player_ids: [3, 4] }, { player_ids: [4, 5] }])