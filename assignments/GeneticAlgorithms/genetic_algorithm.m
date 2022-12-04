% Disciplina          : SBL0080 - Inteligência Computacional
% Professor           : Jarbas Joaci de Mesquita Sá Júnior
% Descrição           : Algoritmo Genético para o Caixeiro Viajante - Trabalho 03
% Autor(a)            : Izaias Machado Pessoa Neto
% Data de Modificação : 02/12/2022

% Matriz de Adjacência fornecida para o problema
matrix = [
    [0, 1, 2, 4, 6, 2, 2, 3, 3, 5, 6, 1, 4, 5];
    [1, 0, 3, 2, 1, 3, 6, 3, 4, 4, 2, 4, 4, 4];
    [2, 3, 0, 1, 3, 3, 2, 3, 4, 1, 3, 5, 5, 6];
    [4, 2, 1, 0, 5, 1, 4, 2, 3, 4, 4, 8, 2, 2];
    [6, 1, 3, 5, 0, 2, 1, 6, 5, 2, 3, 4, 2, 2];
    [2, 3, 3, 1, 2, 0, 3, 1, 2, 3, 5, 7, 3, 4];
    [2, 6, 2, 4, 1, 3, 0, 2, 1, 2, 5, 2, 4, 3];
    [3, 3, 3, 2, 6, 1, 2, 0, 5, 5, 1, 5, 3, 6];
    [3, 4, 4, 3, 5, 2, 1, 5, 0, 1, 4, 4, 5, 3];
    [5, 4, 1, 4, 2, 3, 2, 5, 1, 0, 5, 4, 4, 2];
    [6, 2, 3, 4, 3, 5, 5, 1, 4, 5, 0, 4, 2, 1];
    [1, 4, 5, 8, 4, 7, 2, 5, 4, 4, 4, 0, 1, 3];
    [4, 4, 5, 2, 2, 3, 4, 3, 5, 4, 2, 1, 0, 1];
    [5, 4, 6, 2, 2, 4, 3, 6, 3, 2, 1, 3, 1, 0]
];

n = length(matrix); % Quantidade de cidades
graph = CompleteGraph(matrix); % Monta o grafo do problema

% Quantidade dos melhores indivíduos que são preservados da geração atual para a seguinte (Elitismo)
kBest = 2;

% Quantidade de Gerações
quantityGenerations = 100;
generations = 0 : quantityGenerations;

% Chance de mutação para cada cromossomo
mutationOdds = 0.1;

% Define uma população de 100 indivíduos, 14 cidades e passa o grafo do
% problema
population = Population(100, n, graph);

% Gera uma população aleatória
population = population.randomPopulation();

% Array para armazenar a nota do melhor indivíduo a cada geração
bestSubjectGradePerGeneration = zeros(quantityGenerations + 1, 1);

% Percorre cada geração, desde a 0 até a 100
for i = generations
    % Avalia todos os indivíduos
    subjectGrades = population.evaluateSubjects();

    % Seleciona a nota e o índice do melhor indivíduo
    [bestSubjectGrade, bestSubjectIdx]= max(subjectGrades);

    % Salva a melhor nota em um array a cada geração
    bestSubjectGradePerGeneration(i + 1) = bestSubjectGrade;

    % Seleciona o melhor indivíduo por meio de seu índice
    subject = population.subjects(bestSubjectIdx, :);

    % Calcula o custo do caminho no grafo, para o melhor indivíduo
    bestSubjectPathCost = population.graph.getPathCost(subject);

    fprintf("Geração %d | Nota Melhor Indivíduo: %f | Custo Menor Caminho: %d\n", i, bestSubjectGrade, bestSubjectPathCost);
    
    % Caso seja a população inicial, é criada uma nova população. Para
    % entender é necessário ver a classe Population.
    if i ~= 0
        population = population.createNewPopulation(kBest, mutationOdds);
    end
end

% Ao fim das gerações, é mostrado o indivíduo com melhor avaliação junto
% com o custo para o caminho no grafo.
fprintf(' ===== Resultado ===== \n');
fprintf('Custo Menor Caminho: %d\n', bestSubjectPathCost);

printPath(subject); % Imprime o caminho

% Monta um gráfico da melhor nota em função da genração
plotEvaluationOverGenerations(bestSubjectGradePerGeneration, generations);

% Notas sobre as execuções realizadas:
% Os três melhores indivíduos encontrados foram os seguintes,

% Caminho: 7 -> 8 -> 6 -> 5 -> 2 -> 1 -> 12 -> 13 -> 14 -> 11 -> 4 -> 3 -> 10 -> 9
% Nota: 0.052632
% Custo Caminho: 19

% Caminho: 12 -> 1 -> 3 -> 7 -> 9 -> 10 -> 5 -> 2 -> 4 -> 6 -> 8 -> 11 -> 14 -> 13
% Nota: 0.055556
% Custo Menor Caminho: 18

% Caminho: 12 -> 1 -> 2 -> 5 -> 7 -> 6 -> 9 -> 10 -> 3 -> 4 -> 8 -> 11 -> 14 -> 13
% Nota: 0.055556
% Custo Menor Caminho: 18

function printPath(path)
    % PRINTPATH Imprime um dado caminho
    text = 'Melhor Caminho: \n';
    strPath = string(path);
    joinedPath = join(strPath, ' -> ');
    text = text + joinedPath + '\n';
    fprintf(text);
end

function plotEvaluationOverGenerations(evaluations, generations)
    % PLOTEVALUATIONOVERGENERATIONS Gráfico da melhor nota em função das
    % gerações

    plot(generations, evaluations);
    title('Melhor Indivíduo por Geração')
    xlabel('Geração')
    ylabel('Melhor nota por Geração')
end