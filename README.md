# Personal Trainer

Aplicativo desenvolvido em Flutter para auxiliar um personal trainer no gerenciamento de alunos e no agendamento de aulas.

O projeto foi desenvolvido como atividade individual do 3º trimestre, com o objetivo de integrar um produto do Firebase e uma API externa de forma coerente com o escopo da aplicação.

## Funcionalidades

O aplicativo permite:

- Cadastrar alunos;
- Listar alunos cadastrados;
- Editar dados dos alunos;
- Excluir alunos;
- Definir a quantidade de aulas semanais de cada aluno;
- Consultar o endereço da academia pelo CEP;
- Armazenar os dados dos alunos no Cloud Firestore;
- Agendar aulas para os alunos;
- Listar aulas agendadas;
- Remarcar aulas;
- Excluir aulas;
- Impedir o agendamento de aulas em horários anteriores ao atual;
- Limitar a reposição de uma aula à semana original ou à semana seguinte;
- Excluir as aulas vinculadas quando um aluno é removido.

## Tecnologias utilizadas

- Flutter
- Dart
- Firebase
- Cloud Firestore
- ViaCEP
- HTTP

## Firebase

O produto Firebase escolhido para o projeto foi o **Cloud Firestore**.

O Firestore é utilizado para persistir os dados da aplicação em duas coleções principais:

### `alunos`

Exemplo de documento:

```text
alunos
└── <id>
    ├── nome
    ├── telefone
    ├── aulas_por_semana
    ├── cep
    └── endereco
```

### `aulas`

Exemplo de documento:

```text
aulas
└── <id>
    ├── aluno_id
    ├── aluno_nome
    ├── data_hora
    └── status
```

Cada aula possui referência ao aluno por meio do campo `aluno_id`.

Quando um aluno é excluído, suas aulas também são removidas para evitar registros sem um aluno correspondente.

## API externa - ViaCEP

A API externa escolhida foi a **ViaCEP**.

Ela é utilizada no cadastro de alunos para localizar automaticamente o endereço da academia a partir do CEP informado.

Fluxo da integração:

```text
Usuário informa o CEP
        ↓
Flutter
        ↓
CepService
        ↓
Requisição HTTP
        ↓
ViaCEP
        ↓
Resposta JSON
        ↓
Endereco.fromJson()
        ↓
Endereço exibido na tela
        ↓
Cloud Firestore
```

Dessa forma, a API externa está diretamente integrada ao fluxo de cadastro e edição dos alunos.

## Estrutura do projeto

O código foi organizado separando modelos, serviços e telas:

```text
lib/
├── firebase_options.dart
├── main.dart
│
├── model/
│   ├── aluno.dart
│   ├── aula.dart
│   └── endereco.dart
│
├── service/
│   ├── aluno_service.dart
│   ├── aula_service.dart
│   └── cep_service.dart
│
└── telas/
    ├── tela_alunos.dart
    └── tela_agenda.dart
```

### Models

Representam os dados utilizados pela aplicação.

- `Aluno`: dados pessoais, quantidade de aulas semanais e academia.
- `Aula`: aluno, data, horário e status da aula.
- `Endereco`: dados retornados pela ViaCEP.

### Services

Concentram o acesso aos serviços externos.

- `AlunoService`: operações de alunos no Cloud Firestore.
- `AulaService`: operações da agenda no Cloud Firestore.
- `CepService`: comunicação HTTP com a API ViaCEP.

### Telas

São responsáveis pela interação com o usuário.

- `TelaAlunos`: gerenciamento dos alunos e consulta de CEP.
- `TelaAgenda`: agendamento, remarcação e exclusão das aulas.

## Fluxo da aplicação

```text
                    PERSONAL TRAINER
                           │
              ┌────────────┴────────────┐
              │                         │
           ALUNOS                    AGENDA
              │                         │
      ┌───────┼────────┐        ┌───────┼────────┐
      │       │        │        │       │        │
   Cadastro  Edição  Exclusão Agendar Remarcar Excluir
      │
      ├──────────────► ViaCEP
      │
      ▼
 Cloud Firestore ◄──────────── Agenda
```

## Regras implementadas

### Agendamento

Uma aula é vinculada a um aluno e possui data, horário e status.

Não é permitido cadastrar uma aula em uma data e horário anteriores ao momento atual.

### Remarcação

Uma aula pode ser remarcada dentro da semana original ou da semana seguinte.

Ao ser remarcada, seu status passa de:

```text
AGENDADA
```

para:

```text
REMARCADA
```

### Exclusão de aluno

Ao excluir um aluno, as aulas vinculadas a ele também são excluídas do Firestore.

Isso evita que existam aulas associadas a alunos que não existem mais.

## Como executar

Com o Flutter instalado, instale as dependências:

```bash
flutter pub get
```

Execute o projeto:

```bash
flutter run
```

Para verificar o código:

```bash
flutter analyze
```

Para executar os testes:

```bash
flutter test
```

## Requisitos acadêmicos atendidos

O projeto atende aos requisitos propostos utilizando:

- **Produto Firebase:** Cloud Firestore;
- **API externa:** ViaCEP;
- Integração do Firestore com as telas Flutter;
- Integração da API ViaCEP com a tela de alunos;
- Persistência real dos dados;
- Funcionalidades coerentes com o domínio de gerenciamento de alunos e aulas de um personal trainer.
