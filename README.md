# Book Opinions

## Description
This is a web-app where users can share their opinions about books and book's authors.

Each time that users create a new opinion, a link to worldcat is generate. In this way, other users can find their recommendations.

For some reason, the video link is not showing in the request. This is the link to the video presentation. ![videolink](https://youtu.be/qoIkSvYIzmc)


### Associations

- **Users** have a username and an email. They can follow other users. They can read book opinions of other people and they can create, edit or destroy their own book opinions.
**Opinions** They have a title and a body. Users can read in the index the book opinions of their followed users.
- **Following** is a join table. Each time that a user follows other user, is created a new relationship between them. This relationship can be non-reciprocal.

#### Diagram of database relationships

![diagrammodels](https://www.notion.so/image/https%3A%2F%2Fs3-us-west-2.amazonaws.com%2Fsecure.notion-static.com%2F1905a995-ecb9-4c90-ba18-259b50389310%2FEntity_Relationship_Diagram_(UML_Notation)_(2).png)

## Validations

Validations are defined in the model of each class. New objects need to pass the following validations:

### Users

- **Name**: presence should be true and unique. The username should have more than 3 characters and less than 10.
- **Fullname**: mandatory with a length between 3 and 20 characters.

### OPINIONS

- **Title**: mandatory, with a length between 2 and 50 characters.
- **Body**: mandatory, with a length between 2 and 50 characters.

## Getting started

### Prerequisites

- Ruby
- Rails
- Bundle
- MySQL 3 for development **Note**: You can change the database in GemFile.
- Postgrest for Deployment


### Built With

- [Ruby](https://www.ruby-lang.org/en/) 2.7.0 - A programming language.
- [Ruby on Rails](https://rubyonrails.org/) 6.0.3.1 - A Ruby framework for web development

### Installing

1. Download this repository

`$ git clone repo_url`

2. Install all required gem.

`$ bundle install`

3. Migrate the database.

`$ rails db:migrate`

4.  Run localhost

`$ rails server`

### Running the tests

You can check specs into the folder 'tests'. Run test with

`$ rspec`

Also, you can run tests with

`$ rails test`

If any error relate to selenium webdriver appears, run

`$ bundle install`

If this doesn't solve the problem, open an issue.

#### Tested with

- Test Unit
- RSpec
- Capybara

### Live Version

- [Check here the live version!](https://immense-inlet-58413.herokuapp.com)

## Author

👤 **Juan Paulo Perez Tejada**

- Github: [@Maclenn77](https://github.com/Maclenn77)
- Twitter: [@srjuanpapas](https://twitter.com/srjuanpapas)
- Linkedin: [Juan Paulo Perez Tejada](https://mx.linkedin.com/in/juanpaulopereztejada)

Visit [my blog](https://developerz.software/)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details


## Acknowledgments

* Design idea by [Gregoire Vella](https://www.behance.net/gregoirevella)

## To DO

- Add validations to image sizes
- Find an alternative storage for images
