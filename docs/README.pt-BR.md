# UTFPR IFP Fuses (Simplificado)

Este repositório agora demonstra **apenas dois exemplos básicos** de protocolos com *session types* em Elixir:

1. Cliente envia um inteiro e depois recebe um inteiro do servidor.
2. Cliente recebe um inteiro e depois envia outro inteiro de volta.

O objetivo é mostrar a dualidade `send` <-> `receive` de forma objetiva, sem operadores avançados ou múltiplas escolhas.

## Estrutura

- `lib/session_type.ex`: construtores para `:send`, `:receive` e `:end`, além de `dual/1`.
- `lib/protocol_checker.ex`: confirma se dois protocolos são compatíveis (`dual/1` iguais) e formata protocolos para exibição.
- `main.exs`: executa os dois exemplos com mensagens no terminal.
- `test/utfpr_ifp_fuses_test.exs`: TBD.

## Como executar

```bash
mix run main.exs
```

Saída esperada (resumo):

```
============================================================
DEMONSTRAÇÃO: Session Types
============================================================

------------------------------------------------------------
EXAMPLE 1: !⟨int⟩ followed by ?⟨string⟩
------------------------------------------------------------
Client = !⟨:int⟩.?⟨:string⟩.1
Server = ?⟨:int⟩.!⟨:string⟩.1
Compatible? true

------------------------------------------------------------
EXAMPLE 2: ?⟨bool⟩ followed by !⟨ack⟩
------------------------------------------------------------
Server = ?⟨:bool⟩.!⟨:ack⟩.1
Client = !⟨:bool⟩.?⟨:ack⟩.1
Compatible? true

============================================================
Demonstration completed.
============================================================
```

## Exemplos de sucesso

````bash
mix run examples.exs
````

Resultado esperado (resumo):

```
==================================================
EXAMPLE: Authentication
==================================================

Client: !⟨:username⟩.!⟨:password⟩.?⟨:token⟩.1
Server: ?⟨:username⟩.?⟨:password⟩.!⟨:token⟩.1

✓ Compatible? true

==================================================
EXAMPLE: File Transfer
==================================================

Client: !⟨:filename⟩.?⟨:file_content⟩.?⟨:checksum⟩.1
Server: ?⟨:filename⟩.!⟨:file_content⟩.!⟨:checksum⟩.1

✓ Compatible? true

==================================================
Summary:
  Simple session types ensure send/receive alignment
  See also examples-violations.exs for incompatible cases
==================================================
```

## Exemplos de violação do protocolo
````bash
mix run examples-violations.exs
````

Resultado esperado (resumo):

```
==================================================
Compatibility Violations
==================================================

--------------------------------------------------
CASE 1: Client sends :int but server expects :string
--------------------------------------------------
Client = !⟨:int⟩.1
Server = ?⟨:string⟩.1
Compatible? false

--------------------------------------------------
CASE 2: Client sends then receives, server also wants to send
--------------------------------------------------
Client = !⟨:ping⟩.?⟨:pong⟩.1
Server = !⟨:status⟩.?⟨:ack⟩.1
Compatible? false

--------------------------------------------------
CASE 3: Client ends before sending the second value
--------------------------------------------------
Client = !⟨:token⟩.1
Server = ?⟨:token⟩.?⟨:confirmation⟩.1
Compatible? false

==================================================
End of compatibility violation examples
==================================================
```

- OBS **Sobre a entrega do trabalho** → [`Delivery Points`](docs/DeliveryPoints.md) Existe um arquivo adicional detalhando minha implementação própria inspirada no FuSes, bem como as lições aprendidas durante o desenvolvimento.
