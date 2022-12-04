% Disciplina          : SBL0080 - Inteligência Computacional
% Professor           : Jarbas Joaci de Mesquita Sá Júnior
% Descrição           : Classe da População - Trabalho 03
% Autor(a)            : Izaias Machado Pessoa Neto
% Data de Modificação : 22/11/2022

classdef Population
    % POPULATION Classe que possui atributos e métodos de uma dada
    % população

    properties
        size % Tamanho da População
        quantityNodesChromosome % Quantidade de Nós (Cidades) no Cromossomo
        subjects % Array que armazena os indivíduos
        graph % Composição da Classe com o Grafo do Problema
    end
    
    methods
        function population = Population(size, quantityNodesCromossome, graph)
            population.size = size;
            population.quantityNodesChromosome = quantityNodesCromossome;
            population.graph = graph;
        end

        function population = randomPopulation(population)
            % RANDOMPOPULATION Cria uma população de indivíduos aleatórios

            n = population.quantityNodesChromosome;
            population.subjects = zeros(population.size, n);
            
            % Cada indivíduo da população é criado, com a ordem das cidades
            % sendo aleatória para cada um
            for i = 1 : population.size
                population.subjects(i, :) = randperm(n);
            end
        end

        function value = subjectGrade(population, subject)
            % SUBJECTGRADE Função de avaliação do indivíduo
            %
            % Avalia o indivíduo de forma inversamente proporcional ao
            % custo para percorrer o seu caminho
            
            value = 1 / population.graph.getPathCost(subject);
        end

        function subjectEvaluation = evaluateSubjects(population)
            % EVALUATESUBJECTS Avalia todos os indivíduos da população e
            % retorna um array com as avaliações

            subjectEvaluation = zeros(population.size, 1);

             for i = 1 : population.size
                subject = population.subjects(i, :);
                subjectEvaluation(i, :) = population.subjectGrade(subject);
             end
        end

        function crossingSubject = chooseCrossingSubject(population)
            % CHOOSECROSSINGSUBJECT Roda uma 'roleta' para escolher um
            % indivíduo com base na sua avaliação. Indivíduos com maior
            % nota tem mais chance de serem escolhidos.

            subjectEvaluation = population.evaluateSubjects();
            sumEvaluations = sum(subjectEvaluation);

            limit = rand(1, 1) * sumEvaluations;

            i = 1;
            aux = subjectEvaluation(1, :);
            while aux < limit
                i = i + 1;
                aux = aux + subjectEvaluation(i, :);
            end
        
            crossingSubject = population.subjects(i, :);
        end

        function kBestSubjects = chooseKBestSubjects(population, k)
            % KBESTSUBJECTS Escolhe os k melhores indivíduos da população,
            % com base em suas notas.

            quantitySubjectsChoosen = 0;
            kBestSubjects = zeros(k, population.quantityNodesChromosome);
            subjectEvaluation = population.evaluateSubjects();

            for i = 1 : k
                [~, subjectIdx] = max(subjectEvaluation);
                
                subjectEvaluation(subjectIdx, :) = [];
                quantitySubjectsChoosen = quantitySubjectsChoosen + 1;

                subject = population.subjects(subjectIdx, :);
                kBestSubjects(quantitySubjectsChoosen, :) = subject;
            end
        end

        function children = createNewGeneration(population, childrenQuantity, mutationOdds)
            % CREATENEWGENERATIOn Dada uma população atual, realiza o
            % cruzamento e mutação de uma quantidade de indivíduos.
            %
            % childrenQuantity: Quantidade de filhos
            % mutationOdds: Chance de mutação, está no intervalo inclusivo
            % [0-1]

            % Inicializa um array para armazenar os filhos
            children = zeros(childrenQuantity, population.quantityNodesChromosome);
            
            for i = 1 : (childrenQuantity / 2)
                % Seleciona dois pais
                firstSubject = population.chooseCrossingSubject();
                secondSubject = population.chooseCrossingSubject();
        
                firstChromossome = Chromosome(firstSubject);
                secondChromossome= Chromosome(secondSubject);
        
                % Realiza o cruzamento por mapeamento parcial
                cross = Crossover(firstChromossome, secondChromossome);
                [firstChild, secondChild] = cross.partialMapping();
        
                % Tenta realizar mutações para os filhos
                firstChild.tryMutation(mutationOdds);
                secondChild.tryMutation(mutationOdds);
        
                % Armazena os filhos
                children(i * 2 - 1, :) = firstChild.nodes;
                children(i * 2, :) = secondChild.nodes;
            end
        end

        function newPopulation = createNewPopulation(population, kBest, mutationOdds)
            % CREATENEWPOPULATION Cria uma nova população utilizando
            % elitismo.
            %
            % Os k melhores indivíduos da geração são preservados e o
            % restante da população é substituida por indivíduos de uma
            % nova geração após o crossover e mutação.
            
            % Quantidade de filhos na nova geração
            childrenQuantity = population.size - kBest;

            % Faz os filhos da nova geração
            children = population.createNewGeneration(childrenQuantity, mutationOdds);
            
            % k melhores indivíduos da geração
            kBestSubjects = population.chooseKBestSubjects(kBest);
        
            % Definição da nova população
            newPopulation = Population(population.size, population.quantityNodesChromosome, population.graph);
            
            % Junta os novos filhos com os k melhores indivíduos da geração anterior
            newPopulation.subjects = [children; kBestSubjects];
        end
    end
end

