import Stack

--Prop.: Dada una lista devuelve una pila sin alterar el orden de los elementos.
apilar :: [a] -> Stack a
apilar [] = emptyS
apilar (x:xs) = push x (apilar xs)

--Prop.: Toma un string que representa una expresión aritmética, por ejemplo ”(2 + 3) ∗ 2”, y verifica que la cantidad de paréntesis que abren se corresponda con los que cierran.
balanceado :: String -> Bool
balanceado cs =	parentesisBalanceados emptyS cs
				

parentesisBalanceados :: Stack Char -> String -> Bool
parentesisBalanceados stk [] = isEmptyS stk
parentesisBalanceados stk ('(':cs) = parentesisBalanceados (push '(' stk) cs
parentesisBalanceados stk (')':cs) = 	if not (isEmptyS stk)
										then parentesisBalanceados (pop stk) cs
										else False
parentesisBalanceados stk (c:cs) = parentesisBalanceados stk cs
