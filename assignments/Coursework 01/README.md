# Trabalho 01

## Roteiro

### Questão 01
Construa um programa baseado em lógica fuzzy (inferência de Mamdani) conforme as regras disponibilizadas no [Exercício 18](../../docs/applied-computational-intelligence-exercise18.pdf) do livro "Inteligência Computacional Aplicada à Administração, Economia e Engenharia em Matlab", Hime Aguiar e Oliveira Junior (Coordenadores), Caldeira, A. M.; Machado, M. A. S.; Sousa, R. C.; Tanscheit, R.; Thomson Learning, 2007. O programa deverá solicitar as entradas ao usuário e exibir a saída produzida. (4,0 pontos)

### Questão 02
Usando o conjunto de dados do aerogerador (variável de entrada: velocidade do vento – $m/s$, variável de saída: potência gerada – $kWatts$), determine os modelos de regressão polinomial (graus 2 a 7) com parâmetros estimados pelo método dos mínimos quadrados. (3,0 pontos)

Avalie a qualidade de cada modelo pela métrica $R^2$ e $R^2_{aj}$ (equações 48 e 49, slides sobre Regressão Múltipla).

### Questão 03
Dada a base de dados abaixo, na qual a primeira e segunda colunas são as variáveis regressoras $(x_1$ e $x_2)$ e a terceira coluna é a variável dependente $(y)$, determine o modelo de regressão múltipla (plano) com parâmetros estimados pelo método dos mínimos quadrados. Avalie a qualidade do modelo pela métrica $R^2$. (3,0 pontos)

```
D = [122 139 0.115;
    114 126 0.120;
    086 090 0.105;
    134 144 0.090;
    146 163 0.100;
    107 136 0.120;
    068 061 0.105;
    117 062 0.080;
    071 041 0.100;
    098 120 0.115
];
```

---

Obs. As implementações devem ser em Scilab ou Matlab. Não usar funções que executem diretamente as tarefas pedidas (por exemplo, a função polyfit no Matlab).