# Calculator

## Local Development Setup

### Prerequisites

- Docker - Make sure you have Docker installed on your machine.

### Instalation

1. Clone the repository to your local machine:

`git clone https://github.com/minerado/calculator.git`

2. Navigate to the project directory:

`cd calculator`

3. Setup the project

`docker build --tag 'calculator' . `

### Running the Development Server

1. Start the development server:

`docker run -v .:/app -p 4000:4000 calculator`

This will launch the Elixir development server, and the api will be available at http://localhost:4000.

2. Have fun!
