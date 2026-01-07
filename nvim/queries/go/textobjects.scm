; extends
;; list params
(parameter_list) @parameter_list.outer

;; method receiver
(method_declaration
	receiver: (parameter_list) @receiver.outer)
(method_declaration
	receiver:(
		(parameter_list
			(parameter_declaration) @receiver.inner
		)
	)
)

;; list return and results
(function_declaration
  result: (parameter_list)@result.outer
  body: (block
		  (return_statement
			(expression_list)@return.inner) @return.outer
		  ))

(function_declaration
  	result: (type_identifier)@result.outer)
