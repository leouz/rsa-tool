$ ->	
	formData = () ->
		p: $('#crypto_p').val()
		q: $('#crypto_q').val()
		e: $('#crypto_e').val()
		d: $('#crypto_d').val()
		input: $('#crypto_input').val()
		encrypted: $('#crypto_encrypted').val()
		decrypted: $('#crypto_decrypted').val()

	$('#crypto_p, #crypto_q').change ->
		d = formData()
		if d.p and d.q
			$.ajax
				type: "POST"
				url: "/get_e_possibilities"
				cache: false,
				data: d
				success: (data) ->
					$('#crypto_e').empty().append($('<option>'))
					$('#crypto_e').append($('<option>').append(d)) for d in data					

	$('#crypto_e').change ->
		d = formData()
		if d.p and d.q and d.e
			$.ajax
				type: "POST"
				url: "/get_d"
				cache: false,
				data: d
				success: (data) ->
					$('#crypto_d').empty().val(data).html(data)

	$('#encrypt').click ->
		d = formData()
		if d.p and d.q and d.e and d.d and d.input
			$.ajax
				type: "POST"
				url: "/encrypt"
				cache: false,
				data: d
				success: (data) ->
					$('#crypto_encrypted').empty().val(data)
					$('#crypto_decrypted').empty()

	$('#decrypt').click ->
		d = formData()
		if d.p and d.q and d.e and d.d and d.encrypted
			$.ajax
				type: "POST"
				url: "/decrypt"
				cache: false,
				data: d
				success: (data) ->
					$('#crypto_decrypted').empty().val(data)
	