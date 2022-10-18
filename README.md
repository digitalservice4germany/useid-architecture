# UseID Architecture

## C4 Model

Diagrams as code using [Structurizr](https://structurizr.com)

### Prerequisites

Docker:

```bash
brew install docker --cask
```

### Start Structurizr Lite

See https://structurizr.com/help/lite

```bash
docker pull structurizr/lite
docker run -it --rm -p 8080:8080 -v "$(pwd):/usr/local/structurizr" structurizr/lite
```

Open workspace in browser at http://localhost:8080

## Architecture Decision Records

The `doc/adr` directory contains [architecture decisions](https://cognitect.com/blog/2011/11/15/documenting-architecture-decisions).
For adding new records the [adr-tools](https://github.com/npryce/adr-tools) command-line tool is useful but not strictly necessary:

```bash
brew install adr-tools
```

## eID Flow and Integration

Find the eID flows including all relevant components and integration docs in `doc/eID`. The flow files contain [Mermaid sequence diagrams](https://mermaid-js.github.io/mermaid/#/sequenceDiagram). 

## Contributing

Everyone is welcome to contribute the development of this project. You can contribute by opening pull request,
providing documentation or answering questions or giving feedback. Please always follow the guidelines and our
[Code of Conduct](CODE_OF_CONDUCT.md).

## Contributing code

Open a pull request with your changes and it will be reviewed by someone from the team. When you submit a pull request,
you declare that you have the right to license your contribution to the DigitalService and the community.
By submitting the patch, you agree that your contributions are licensed under the EUPL license.

Please make sure that your changes have been tested before submitting a pull request.


