# Game Galaxy
Game Galaxy is an online video game store where users can browse and purchase games. The application includes user and admin roles, a shopping cart, a search functionality using Elasticsearch, and order processing with email confirmations.
## Features
- User authentication (sign up, login, logout) using Devise
- Admin role with abilities to manage games (create, edit, delete)
- Game catalog with search functionality powered by Elasticsearch
- Shopping cart for users to add games and proceed to checkout
- Order processing with order confirmation sent via email
- Tailwind CSS for styling
## Installation
### Prerequisites
- Ruby 3.3.0
- Rails 7.1.3.3
- Elasticsearch
- SQLite3
## Setup
1. Clone the repository:
```
git clone https://github.com/your-username/game-galaxy.git
cd game-galaxy
```
2. Install dependencies:
```
bundle install
```
3. Setup the database:
```
rails db:create
rails db:migrate
```
4. Run Elasticsearch:
```
elasticsearch
```
5. Configure Action Mailer by setting environment variables in .env file:
```
SMTP_USERNAME=your_email@gmail.com
SMTP_PASSWORD=your_email_password
```
6. Start the Rails server:
```
rails server
```
## Configuration
### Action Mailer
Configure Action Mailer in config/environments/development.rb and config/environments/production.rb to use SMTP with Gmail:
```
config.action_mailer.delivery_method = :smtp
config.action_mailer.smtp_settings = {
  address: 'smtp.gmail.com',
  port: 587,
  domain: 'example.com',
  user_name: ENV['SMTP_USERNAME'],
  password: ENV['SMTP_PASSWORD'],
  authentication: 'plain',
  enable_starttls_auto: true
}
config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
```