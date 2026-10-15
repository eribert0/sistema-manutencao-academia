-- =====================================================================
-- Sistema de Controle de Manutenção de Equipamentos de Academia
-- Povoamento Estratégico (DML) - PARTE 1
-- Relacionamento 1:N escolhido: Equipamento (1) possui (N) Ordem_Servico
-- =====================================================================

DROP DATABASE IF EXISTS academia_manutencao;
CREATE DATABASE academia_manutencao CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE academia_manutencao;

-- ---------------------------------------------------------------------
-- 0. ESTRUTURA (DDL)
-- ---------------------------------------------------------------------
CREATE TABLE Funcionario (
    id_funcionario INT AUTO_INCREMENT PRIMARY KEY,
    nome           VARCHAR(100) NOT NULL,
    cargo          VARCHAR(50)  NOT NULL
);

CREATE TABLE Equipamento (
    id_equipamento    INT AUTO_INCREMENT PRIMARY KEY,
    nome_aparelho     VARCHAR(100) NOT NULL,
    status_interdicao VARCHAR(20)  NOT NULL DEFAULT 'Liberado'
);

CREATE TABLE Tecnico (
    id_tecnico INT AUTO_INCREMENT PRIMARY KEY,
    nome       VARCHAR(100) NOT NULL
);

-- Atributo multivalorado "telefone" vira tabela própria
CREATE TABLE Telefone_Tecnico (
    id_tecnico INT         NOT NULL,
    telefone   VARCHAR(20) NOT NULL,
    PRIMARY KEY (id_tecnico, telefone),
    FOREIGN KEY (id_tecnico) REFERENCES Tecnico (id_tecnico)
);

CREATE TABLE Peca (
    id_peca            INT AUTO_INCREMENT PRIMARY KEY,
    nome_peca          VARCHAR(100) NOT NULL,
    quantidade_estoque INT NOT NULL DEFAULT 0
);

CREATE TABLE Ordem_Servico (
    id_os           INT AUTO_INCREMENT PRIMARY KEY,
    data_abertura   DATE          NOT NULL,
    data_fechamento DATE          NULL,
    status          VARCHAR(20)   NOT NULL,
    custo_total     DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    id_funcionario  INT NOT NULL,   -- abre
    id_tecnico      INT NOT NULL,   -- executa
    id_equipamento  INT NOT NULL,   -- possui (FK do lado N)
    FOREIGN KEY (id_funcionario) REFERENCES Funcionario (id_funcionario),
    FOREIGN KEY (id_tecnico)     REFERENCES Tecnico (id_tecnico),
    FOREIGN KEY (id_equipamento) REFERENCES Equipamento (id_equipamento)
);

CREATE TABLE Alerta (
    id_alerta       INT AUTO_INCREMENT PRIMARY KEY,
    data_hora       DATETIME     NOT NULL,
    descricao_falha VARCHAR(255) NOT NULL,
    status          VARCHAR(20)  NOT NULL DEFAULT 'Pendente',
    id_funcionario  INT NOT NULL,   -- registra
    id_equipamento  INT NOT NULL,   -- refere-se a
    id_os           INT NULL,       -- gera (nula: sem OS / descartado)
    FOREIGN KEY (id_funcionario) REFERENCES Funcionario (id_funcionario),
    FOREIGN KEY (id_equipamento) REFERENCES Equipamento (id_equipamento),
    FOREIGN KEY (id_os)          REFERENCES Ordem_Servico (id_os)
);

CREATE TABLE Uso_Peca (
    id_os                INT NOT NULL,
    id_peca              INT NOT NULL,
    quantidade_utilizada INT NOT NULL,
    PRIMARY KEY (id_os, id_peca),
    FOREIGN KEY (id_os)   REFERENCES Ordem_Servico (id_os),
    FOREIGN KEY (id_peca) REFERENCES Peca (id_peca)
);

-- ---------------------------------------------------------------------
-- DADOS DE APOIO (necessários para as chaves estrangeiras da OS)
-- ---------------------------------------------------------------------
INSERT INTO Funcionario (nome, cargo) VALUES ('Carlos Mendes', 'Gestor');
INSERT INTO Funcionario (nome, cargo) VALUES ('Fernanda Lima', 'Gestora');
INSERT INTO Funcionario (nome, cargo) VALUES ('Rafael Souza', 'Professor');
INSERT INTO Funcionario (nome, cargo) VALUES ('Juliana Alves', 'Professora');
INSERT INTO Funcionario (nome, cargo) VALUES ('Marcos Teixeira', 'Recepcionista');

INSERT INTO Tecnico (nome) VALUES ('Roberto Nascimento');
INSERT INTO Tecnico (nome) VALUES ('Paulo Henrique Dias');
INSERT INTO Tecnico (nome) VALUES ('Ana Beatriz Costa');

INSERT INTO Telefone_Tecnico (id_tecnico, telefone) VALUES (1, '(84) 99911-2233');
INSERT INTO Telefone_Tecnico (id_tecnico, telefone) VALUES (1, '(84) 3322-4455');
INSERT INTO Telefone_Tecnico (id_tecnico, telefone) VALUES (2, '(84) 98877-6655');
INSERT INTO Telefone_Tecnico (id_tecnico, telefone) VALUES (3, '(84) 99655-4433');

-- =====================================================================
-- PARTE 1.1 - TABELA A (lado "1"): EQUIPAMENTO -> 8 INSERTs individuais
-- Registros 1 a 7: terão ordens de serviço | Registro 8: NÃO terá nenhuma
-- =====================================================================
INSERT INTO Equipamento (nome_aparelho, status_interdicao) VALUES ('Esteira Ergométrica Movement LX', 'Liberado');   -- id 1
INSERT INTO Equipamento (nome_aparelho, status_interdicao) VALUES ('Bicicleta Ergométrica Vertical', 'Liberado');     -- id 2
INSERT INTO Equipamento (nome_aparelho, status_interdicao) VALUES ('Leg Press 45 Graus', 'Interditado');              -- id 3
INSERT INTO Equipamento (nome_aparelho, status_interdicao) VALUES ('Polia Alta (Pulley)', 'Liberado');                -- id 4
INSERT INTO Equipamento (nome_aparelho, status_interdicao) VALUES ('Elíptico Profissional', 'Interditado');           -- id 5
INSERT INTO Equipamento (nome_aparelho, status_interdicao) VALUES ('Supino Reto Articulado', 'Liberado');             -- id 6
INSERT INTO Equipamento (nome_aparelho, status_interdicao) VALUES ('Esteira Ergométrica Pro 2', 'Interditado');       -- id 7 (4 OS)
INSERT INTO Equipamento (nome_aparelho, status_interdicao) VALUES ('Cadeira Extensora', 'Liberado');                  -- id 8 (sem OS)

-- =====================================================================
-- PARTE 1.2 - TABELA B (lado "N"): ORDEM_SERVICO -> INSERTs individuais
-- Colunas: data_abertura, data_fechamento, status, custo_total,
--          id_funcionario (abre), id_tecnico (executa), id_equipamento (FK)
-- =====================================================================

-- Equipamento 1 (2 OS)
INSERT INTO Ordem_Servico (data_abertura, data_fechamento, status, custo_total, id_funcionario, id_tecnico, id_equipamento) VALUES ('2026-01-12', '2026-01-14', 'Concluída', 350.00, 1, 1, 1);
INSERT INTO Ordem_Servico (data_abertura, data_fechamento, status, custo_total, id_funcionario, id_tecnico, id_equipamento) VALUES ('2026-06-03', '2026-06-04', 'Concluída', 120.00, 2, 2, 1);

-- Equipamento 2 (2 OS)
INSERT INTO Ordem_Servico (data_abertura, data_fechamento, status, custo_total, id_funcionario, id_tecnico, id_equipamento) VALUES ('2026-02-05', '2026-02-07', 'Concluída', 210.50, 1, 3, 2);
INSERT INTO Ordem_Servico (data_abertura, data_fechamento, status, custo_total, id_funcionario, id_tecnico, id_equipamento) VALUES ('2026-08-19', '2026-08-22', 'Concluída', 480.00, 2, 1, 2);

-- Equipamento 3 (2 OS - a segunda ainda em execução)
INSERT INTO Ordem_Servico (data_abertura, data_fechamento, status, custo_total, id_funcionario, id_tecnico, id_equipamento) VALUES ('2026-03-10', '2026-03-12', 'Concluída', 95.90, 1, 2, 3);
INSERT INTO Ordem_Servico (data_abertura, data_fechamento, status, custo_total, id_funcionario, id_tecnico, id_equipamento) VALUES ('2026-09-02', NULL, 'Em execução', 0.00, 2, 3, 3);

-- Equipamento 4 (2 OS)
INSERT INTO Ordem_Servico (data_abertura, data_fechamento, status, custo_total, id_funcionario, id_tecnico, id_equipamento) VALUES ('2026-04-08', '2026-04-09', 'Concluída', 60.00, 2, 1, 4);
INSERT INTO Ordem_Servico (data_abertura, data_fechamento, status, custo_total, id_funcionario, id_tecnico, id_equipamento) VALUES ('2026-07-15', '2026-07-18', 'Concluída', 275.00, 1, 2, 4);

-- Equipamento 5 (2 OS - a segunda ainda aberta)
INSERT INTO Ordem_Servico (data_abertura, data_fechamento, status, custo_total, id_funcionario, id_tecnico, id_equipamento) VALUES ('2026-02-20', '2026-02-25', 'Concluída', 690.00, 2, 3, 5);
INSERT INTO Ordem_Servico (data_abertura, data_fechamento, status, custo_total, id_funcionario, id_tecnico, id_equipamento) VALUES ('2026-10-05', NULL, 'Aberta', 0.00, 1, 1, 5);

-- Equipamento 6 (2 OS)
INSERT INTO Ordem_Servico (data_abertura, data_fechamento, status, custo_total, id_funcionario, id_tecnico, id_equipamento) VALUES ('2026-05-14', '2026-05-15', 'Concluída', 45.00, 1, 2, 6);
INSERT INTO Ordem_Servico (data_abertura, data_fechamento, status, custo_total, id_funcionario, id_tecnico, id_equipamento) VALUES ('2026-09-21', '2026-09-23', 'Concluída', 130.00, 2, 3, 6);

-- Equipamento 7 (4 OS - útil para GROUP BY / COUNT)
INSERT INTO Ordem_Servico (data_abertura, data_fechamento, status, custo_total, id_funcionario, id_tecnico, id_equipamento) VALUES ('2026-01-27', '2026-01-29', 'Concluída', 520.00, 1, 1, 7);
INSERT INTO Ordem_Servico (data_abertura, data_fechamento, status, custo_total, id_funcionario, id_tecnico, id_equipamento) VALUES ('2026-04-22', '2026-04-24', 'Concluída', 310.00, 2, 2, 7);
INSERT INTO Ordem_Servico (data_abertura, data_fechamento, status, custo_total, id_funcionario, id_tecnico, id_equipamento) VALUES ('2026-07-30', '2026-08-03', 'Concluída', 890.00, 1, 1, 7);
INSERT INTO Ordem_Servico (data_abertura, data_fechamento, status, custo_total, id_funcionario, id_tecnico, id_equipamento) VALUES ('2026-10-09', NULL, 'Em execução', 0.00, 2, 3, 7);

-- Equipamento 8: NENHUMA OS (propositalmente) -> testará LEFT JOIN

-- ---------------------------------------------------------------------
-- CONFERÊNCIA: deve retornar 2,2,2,2,2,2,4 e 0 para o equipamento 8
-- ---------------------------------------------------------------------
SELECT e.id_equipamento, e.nome_aparelho, COUNT(o.id_os) AS total_os
FROM Equipamento e
LEFT JOIN Ordem_Servico o ON o.id_equipamento = e.id_equipamento
GROUP BY e.id_equipamento, e.nome_aparelho
ORDER BY e.id_equipamento;