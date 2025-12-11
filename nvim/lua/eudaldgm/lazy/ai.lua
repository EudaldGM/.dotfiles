return{
	'huggingface/llm.nvim',
	config = function()
	  require('llm').setup({
		model = "codellama:7b-code",
		url = "http://localhost:11434/v1/completions",
		-- cf https://github.com/ollama/ollama/blob/main/docs/api.md#parameters
		request_body = {
		  -- Modelfile options for the model you use
		  options = {
			temperature = 0.2,
			top_p = 0.95,
		  }
		}
	  })
	end
}
