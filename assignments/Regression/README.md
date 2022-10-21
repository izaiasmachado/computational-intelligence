# Regression

## Regressão Múltipla

### Implementation

- [Class instances](./exercise03.m)
- [Multiple Regression Class](./MultipleRegression.m)

### Guide

Given the database below, in which the first and second columns are the regressors variables $(x_1$ and $x_2)$ and the third column is the dependent variable $(y)$, determine the multiple regression model (plan) with parameters estimated by the method of least squares. Evaluate the quality of the model by the metric $R^2$.

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

## Regressão Polinomial

### Implementation

- [Class instances](./exercise02.m)
- [Polynomial Regression Class](./PolynomialRegression.m)

### Guide

Using [wind turbine dataset](../../datasets/aerogerador.dat) (input variable: wind speed – $m/s$, output variable: generated power – $kWatts$), determine polynomial regression models (grades 2 to 7) with parameters estimated by the least squares method.

Evaluate the quality of each model by the metric $R^2$ and $R^2_{adjusted}$ (for polynomial regression).
