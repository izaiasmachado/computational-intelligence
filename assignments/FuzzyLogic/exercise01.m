% Disciplina          : SBL0080 - Inteligência Computacional
% Professor           : Jarbas Joaci de Mesquita Sá Júnior
% Descrição           : Questão 01 - Trabalho 01
% Autor(a)            : Izaias Machado Pessoa Neto
% Data de Modificação : 17/10/2022

% QUESTAO01 O problema foi organizado em classes para reciclar código e
% que ficasse mais legível. As classes usadas para essa questão são toadas
% que estão na pasta de Lógica Fuzzy.

%% Pede valores dos Inputs
promptTemperatura = sprintf('Digite o valor da Temperatura');
temperatura = inputdlg('Digite o valor da temperatura', promptTemperatura);

promptPreco = sprintf('Digite o Preço Unitário');
preco = inputdlg('Digite o Preço Unitário', promptPreco);

temperatura = str2double(temperatura);
preco = str2double(preco);

%% Variáveis
quantidadeDePontos = 101;
rangeTemperatura = [15 45];
rangePrecoUnitario = [1 6];
rangeConsumo = [500 6000];

%% Funções de Pertencimento
% Entrada
temeperaturaAmbienteBaixa = MembershipFunction(rangeTemperatura, 'gaussmf', [6.369, 15]);
temeperaturaAmbienteMedia = MembershipFunction(rangeTemperatura, 'gaussmf', [6.369, 30]);
temeperaturaAmbienteAlta = MembershipFunction(rangeTemperatura, 'gaussmf', [6.369, 45]);

precoUnitarioBaixo = MembershipFunction(rangePrecoUnitario, 'gaussmf', [1.061, 1]);
precoUnitarioMedio = MembershipFunction(rangePrecoUnitario, 'gaussmf', [1.061, 3.05]);
precoUnitarioAlto = MembershipFunction(rangePrecoUnitario, 'gaussmf', [1.061, 6]);

% Saída
consumoPequeno = MembershipFunction(rangeConsumo, 'trimf', [-2250, 500, 3250]);
consumoMedio = MembershipFunction(rangeConsumo, 'trimf', [500, 3250, 6000]);
consumoGrande= MembershipFunction(rangeConsumo, 'trimf', [3250, 6000, 8750]);

%% Regras (AND)
r1 = Rule([temeperaturaAmbienteBaixa, precoUnitarioBaixo], 'and');
r2 = Rule([temeperaturaAmbienteBaixa, precoUnitarioMedio], 'and');
r3 = Rule([temeperaturaAmbienteBaixa, precoUnitarioAlto], 'and');
r4 = Rule([temeperaturaAmbienteMedia, precoUnitarioBaixo], 'and');
r5 = Rule([temeperaturaAmbienteMedia, precoUnitarioMedio], 'and');
r6 = Rule([temeperaturaAmbienteMedia, precoUnitarioAlto], 'and');
r7 = Rule([temeperaturaAmbienteAlta, precoUnitarioBaixo], 'and');
r8 = Rule([temeperaturaAmbienteAlta, precoUnitarioMedio], 'and');
r9 = Rule([temeperaturaAmbienteAlta, precoUnitarioAlto], 'and');

%% Implicações
implicacaoConsumoPequeno = Implication([r3, r6, r9]);
implicacaoConsumoMedio = Implication([r2, r5, r8]);
implicacaoConsumoGrande = Implication([r1, r4, r7]);

implications = [implicacaoConsumoPequeno, implicacaoConsumoMedio, implicacaoConsumoGrande];
outputMFs = [consumoPequeno, consumoMedio, consumoGrande];

%% Agregação
agregation = Agregation(implications, outputMFs, rangeConsumo);

%% Cálculo do Centroide
[x, px] = agregation.getOutput([temperatura, preco], quantidadeDePontos);
consumo = Defuzzy.calculateCentroid(x, px);
fprintf('O valor do consumo para Temperatura %.3f e Preço Unitário %.3f é %.3f\n', temperatura, preco, consumo);
