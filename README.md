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

## eID Flow

Find the eID flows including all relevant components in `doc/eID/`. The files contain a [PlantUML](https://plantuml.com/) 
representation of sequence diagrams. To display the diagrams use a suitable IDE plugin or copy it to [http://www.plantuml.com/plantuml/](http://www.plantuml.com/plantuml/).