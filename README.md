# Sistema de Controle de Manutenção de Equipamentos de Academia

## 1. Contexto e Minimundo
Este projeto visa resolver um problema comum em academias: o controle ineficiente de quebras e manutenções de aparelhos de musculação e aeróbicos (como esteiras, bicicletas e polias). Atualmente, quando um equipamento quebra, o aviso é feito de forma verbal ou informal, causando demora no conserto, falta de histórico sobre o desgaste das máquinas e riscos para a segurança dos alunos.

O sistema automatiza esse fluxo, registrando desde o momento em que a falha é identificada até a conclusão do reparo técnico, permitindo à gestão acompanhar quais aparelhos dão mais problemas e o custo das manutenções.

## 2. Regras de Negócio e Processos
1. **Identificação do problema:** Qualquer funcionário da academia (professor, recepcionista, gestor) que perceba uma falha em um equipamento, seja por observação própria ou por relato de um aluno, registra um **Alerta** no sistema, informando o equipamento afetado e descrevendo a falha.
2. **Triagem do alerta:** O gestor analisa os alertas pendentes e decide se o problema exige intervenção técnica. Se o alerta for improcedente (ex.: aparelho apenas desregulado, alerta duplicado), ele é encerrado sem gerar OS. Se houver risco aos alunos, o gestor interdita o equipamento imediatamente.
3. **Abertura da Ordem de Serviço (OS):** Para alertas procedentes, o gestor abre uma OS vinculada ao alerta que a originou e ao equipamento, registrando a data de abertura. Um mesmo equipamento pode ter vários alertas sobre a mesma falha, e todos eles podem ser atendidos por uma única OS.
4. **Execução técnica:** A OS é atribuída a um técnico responsável. Durante o conserto, ele pode utilizar uma ou mais peças de reposição, registrando a quantidade de cada uma.
5. **Fechamento:** Após o reparo, o técnico encerra a OS (data de fechamento). O sistema dá baixa no estoque das peças utilizadas, calcula o custo total da OS e o gestor libera o equipamento para uso.
