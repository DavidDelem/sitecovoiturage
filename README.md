# README

Site de covoiturage réalisé en Ruby On Rails dans le cadre du cours de systèmes répartis à l'UQAC


## Pour commencer 

```
bundle install
rails db:create
rails db:migrate
```
Si vous avez une erreur avec bcrypt

```
gem uninstall bcrypt
gem uninstall bcrypt-ruby
gem install bcrypt --platform=ruby
```
