## Entidades
- São objetos do mundo real que podem ser represantados no DER como tabelas, que possuem os atributos. 
    - **Chave Primária (PK)**
        - Valor sempre será único.
        - Não pode ser nulo.
        - A Chave primária é única.
        - Não pode ser alterada.
    - **Chave estrangeira (FK)**
        - Referencia uma chave primária de uma tabela em outra tabela.

    - **Relacionamento de Entidades**
        - *Um para Um*: indica que um registro está ligado a outro registro de outra tabela, sendo essencial ver a obrigatoriedade do mesmo.
        - *Um para Muitos*: quando um registro de uma tabela está atrelado a um ou muitos registros de outra tabela
        - *Muito para Muitos*: esse tipo de relacionamento se refere quando muitos registros de uma tabela se relaciona com muitos de outras tabelas, porém eles não podem se repetir.

    - **Entidades Fortes**
        - São entidades que não dependem de nenhuma outra entidade para existir. Um exemplo seria, em uma escola, temos duas entidades `Alunos` e `Professores`, ambas não dependem de nenhuma outra entidade ou fator para existir, dessa forma elas são uma entidade forte.
    - **Entidades Fracas**
        - São entidades que só existem se uma outra entidade existir, sendo totalmente dependente delas. Um exemplo, seria `Notas` de um aluno da entidade `Alunos`, essa tabela necessáriamente depende de um aluno para existir, dessa forma elas são consideradas entidades fracas.
    - **Entidades Associativa**
        - Essa entidade é uma solução para unir duas entidades no qual possuem relacionamento de muito para muitos. Usando como exemplo `Alunos` e `Disciplinas`, um aluno pode ter muitas disciplicas e uma disciplina pode possuir diversos alunos, então entra um questionamento:
        *Não podemos colocar uma  chave de `Disciplinas` em `Alunos`, pois um aluno tem várias e o mesmo ao contrário. Como podemos representar esse tipo de relacionamento?*
        A resposta é simples, criamos uma tabela associativa que irá receber ambas chaves, ela vai representar o relacionamento de muito para muitos 
