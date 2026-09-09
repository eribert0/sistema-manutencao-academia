### 1. Entidades

* **Funcionário:** Representa um conjunto de objetos ou coisas do mundo real sobre os quais a organização precisa guardar informações, neste caso, os professores e gestores da academia.
* **Equipamento:** Entidade forte que representa os aparelhos de musculação e aeróbicos (esteiras, bicicletas, etc).
* **Alerta:** Entidade que registra o aviso de avaria feito pelo funcionário.
* **Ordem_Servico:** Entidade que gerencia o conserto e a interdição do equipamento.
* **Técnico:** Entidade forte que representa o profissional alocado para realizar a manutenção.
* **Peça:** Entidade forte que representa os itens de reposição disponíveis no estoque.
* **Uso_Peca:** Uma entidade associativa criada para resolver um relacionamento de muitos para muitos (N:M) entre Ordem_Servico e Peça.

### 2. Relacionamentos e Cardinalidades

Associações entre as entidades identificada, indicando a cardinalidade de ambos os lados:

* **[Funcionário] (1:N) registra (1:1) [Alerta]**
  * **Explicação:** Um funcionário pode registrar vários (N) alertas ao longo do tempo, mas cada alerta é registrado por apenas 1 funcionário específico.
* **[Alerta] (N:1) refere-se a (1:N) [Equipamento]**
  * **Explicação:** Um equipamento pode receber vários (N) alertas diferentes, mas um alerta refere-se a apenas 1 equipamento.
* **[Equipamento] (1:N) possui (1:1) [Ordem_Servico]**
  * **Explicação:** Um equipamento pode ter um histórico com N ordens de serviço, mas cada ordem de serviço aberta pertence a apenas 1 equipamento.
* **[Técnico] (1:N) executa (1:1) [Ordem_Servico]**
  * **Explicação:** Um técnico executa N ordens de serviço, mas assumimos que cada ordem é executada por 1 técnico responsável.
* **[Ordem_Servico] (N:M) utiliza (N:M) [Peça]**
  * **Explicação:** Uma ordem de serviço pode utilizar várias peças, e uma mesma peça (ex: parafuso) pode ser usada em várias ordens de serviço. No modelo lógico, essa relação N:M exige a criação da Entidade Associativa "Uso_Peca".
 
### 3. Atributos

Para cada entidade, estas são as características ou propriedades que qualificam a entidade:

* **Funcionário:** `ID_Funcionario` (Chave Primária), `Nome` (Atributo Simples), `Cargo` (Atributo Simples).
* **Equipamento:** `ID_Equipamento` (Chave Primária), `Nome_Aparelho` (Atributo Simples), `Status_Interdicao` (Atributo Simples).
* **Alerta:** `ID_Alerta` (Chave Primária), `Data_Hora` (Atributo Simples), `Descricao_Falha` (Atributo Simples).
* **Ordem_Servico:** `ID_OS` (Chave Primária), `Data_Abertura` (Atributo Simples), `Data_Fechamento` (Atributo Simples), `Custo_Total` (Atributo Derivado).
* **Técnico:** `ID_Tecnico` (Chave Primária), `Nome` (Atributo Simples), `Telefone` (Atributo Multivalorado, pois um técnico pode ter múltiplos números).
* **Peça:** `ID_Peca` (Chave Primária), `Nome_Peca` (Atributo Simples), `Quantidade_Estoque` (Atributo Simples).
* **Uso_Peca (Entidade Associativa):** `ID_OS` (Chave Estrangeira/Identificador), `ID_Peca` (Chave Estrangeira/Identificador), `Quantidade_Utilizada` (Atributo Próprio da associação).

### 4. Diagrama Entidade e Relacionamento (DER)
