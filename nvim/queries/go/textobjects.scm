; extends
;; list params
(parameter_list) @parameter_list.outer

;; method id
(method_declaration
	receiver: (parameter_list) @receiver.outer)
(method_declaration
	receiver:(
		(parameter_list
			(parameter_declaration) @receiver.inner
		)
	)
)
