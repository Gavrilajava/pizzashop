# README for PizzaApp

## Overview

This is the simple implementation of text messaging feature for the pizze shop application. User creates an order for pizza, an every time order status updates, user gets a text message.
User gives consent to recieve text messages. User number isn't verrified upon first sent, however if there is an error, app stops sending messages for that order.

## System Requirements

To run this application, you will need:

- Ruby version 3.2.2
- Rails version 7
- A PostgreSQL database server (or another supported database)
- Node.js and Yarn for JavaScript management

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Setup

1. **Clone the Repository**

   ```
   git clone https://github.com/Gavrilajava/pizzashop.git
   cd tech-assess-app
   ```

2. **Install Dependencies**

   ```
   bundle install
   yarn install
   ```

3. **Twilio Credentials**

You will need to set up your Twilio credentials. type into the console:

```
rails credentails:edit
```

Your default text editor will open the file with credentials. Add these lines:

```
twilio:
account_sid: your_twilio_account_sid,
auth_token: your_twilio_auth_token,
from: your_twilio_phone_number_or_messaging_service
webhook_url: "#{your_external_ip_or_domain}/webhooks/text_messages"

```

Replace `your_twilio_account_sid`, `your_twilio_auth_token`, and `your_twilio_phone_number_or_messaging_service` with your actual Twilio credentials.
Last item is optional and need to get status updates

4. **Database Setup**

Run the following commands to set up the database:

```

rails db:create
rails db:migrate

```

5. **Running the Application**

Start the Rails server:

```

rails server

```

Optionnally you can add external ip here to get the notifications, or you can set up a proxy to get requests from outer world.
Access the application via [http://localhost:3000](http://localhost:3000) in your browser.

## Running the Tests

To run the automated tests for this system, execute:

```

bundle exec rspec

```

## License

This project is licensed under the [MIT License](LICENSE.md).

## Contact

For any queries or suggestions, feel free to contact me.
