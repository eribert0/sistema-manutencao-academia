# Sistema de Controle de Manutenção de Equipamentos de Academia

## 1. Contexto e Minimundo
Este projeto visa resolver um problema comum em academias: o controle ineficiente de quebras e manutenções de aparelhos de musculação e aeróbicos (como esteiras, bicicletas e polias). Atualmente, quando um equipamento quebra, o aviso é feito de forma verbal ou informal, causando demora no conserto, falta de histórico sobre o desgaste das máquinas e riscos para a segurança dos alunos.

O sistema automatiza esse fluxo, registrando desde o momento em que a falha é identificada até a conclusão do reparo técnico, permitindo à gestão acompanhar quais aparelhos dão mais problemas e o custo das manutenções.

## 2. Regras de Negócio e Processos
1. **Identificação do Problema:** Qualquer funcionário ou professor da academia pode registrar um alerta de avaria informando o equipamento afetado.
2. **Abertura de Ordem de Serviço (OS):** O gestor avalia o alerta, interdita o aparelho se necessário, e abre oficialmente uma Ordem de Serviço vinculada ao equipamento.
3. **Execução Técnica:** Um técnico de manutenção é alocado para a OS. Durante o conserto, ele pode utilizar uma ou mais peças de reposição.
4. **Fechamento:** Após o reparo, o técnico encerra a OS, o sistema atualiza o estoque de peças e o equipamento é liberado para uso novamente.
