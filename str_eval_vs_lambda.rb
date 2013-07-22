str = 'raise StandardError'
l = -> { raise StandardError }

def eval_call(str)
  eval(str)
end

def lambda_call(l)
  l.call
end

eval_call(str)
# doesn't refer to the original str __LINE__ in stacktrace
# str_eval_vs_lambda.rb:5:in `eval': StandardError (StandardError)

lambda_call(l)
# refer to the original lambda
# str_eval_vs_lambda.rb:2:in `block in <main>': StandardError (StandardError)
