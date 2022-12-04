```
% Disciplina      : SBL0080 - Inteligência Computacional
% Professor       : Jarbas Joaci de Mesquita Sá Júnior
% Descrição       : Trabalho 03 - Algoritmos Genéticos
% Autor(a)        : Izaias Machado Pessoa Neto
% Data de Entrega : 02/12/2022
```

## Versões de Software

- Sistema Operacional: Windows 11 (64 Bits) - Versão 21H2
- Matlab: R2022b (9.13.0.2049777)

## Execução e Funcionamento

Para executar o programa, você deve abrir a pasta relativa ao projeto no Matlab e executar
o script `genetic_algorithm`.

O programa mostra o número da geração, a nota do melhor indivíduo de cada geração e também o
custo para realizar o caminho do melhor indivíduo.

Ao fim, é mostrado o custo do menor caminho e também o próprio caminho. Além disso, é montado 
um gráfico que relaciona o melhor indivíduo em função de sua geração.

## Árvore de Arquivos

O arquivo `genetic_algorithm` é a implementação em si do algoritmo genético. O projeto
foi estruturado em classes com funções auxiliares. Cada classe/script possui a descrição
do seu funcionamento comentada ao longo do código.

O crossover por mapeamento parcial e a mutação por permutação de elementos se encontram,
respectivamente, nas classes `Crossover` e `Chromosome`.

```
.
├── Chromosome.m
├── CompleteGraph.m
├── Crossover.m
├── Population.m
├── README.txt
├── Utils.m
└── genetic_algorithm.m
```

