$ ->	
	formData = () ->
		p: $('#rsa #rsa_p').val()
		q: $('#rsa #rsa_q').val()
		e: $('#rsa #rsa_e').val()
		d: $('#rsa #rsa_d').val()
		input: $('#rsa #rsa_input').val()
		encrypted: $('#rsa #rsa_encrypted').val()
		decrypted: $('#rsa #rsa_decrypted').val()

	$('#rsa #rsa_p, #rsa #rsa_q').change ->
		d = formData()
		if d.p and d.q
			$.ajax
				type: "POST"
				url: "/rsa/get_e_possibilities"
				cache: false,
				data: d
				success: (data) ->
					$('#rsa #rsa_e').empty().append($('<option>'))
					$('#rsa #rsa_e').append($('<option>').append(d)) for d in data					

	$('#rsa #rsa_e').change ->
		d = formData()
		if d.p and d.q and d.e
			$.ajax
				type: "POST"
				url: "/rsa/get_d"
				cache: false,
				data: d
				success: (data) ->
					$('#rsa #rsa_d').empty().val(data).html(data)

	$('#rsa #encrypt').click ->
		d = formData()
		if d.p and d.q and d.e and d.d and d.input
			$.ajax
				type: "POST"
				url: "/rsa/encrypt"
				cache: false,
				data: d
				success: (data) ->
					$('#rsa #rsa_encrypted').empty().val(data)
					$('#rsa #rsa_decrypted').empty()

	$('#rsa #decrypt').click ->
		d = formData()
		if d.p and d.q and d.e and d.d and d.encrypted
			$.ajax
				type: "POST"
				url: "/rsa/decrypt"
				cache: false,
				data: d
				success: (data) ->
					$('#rsa #rsa_decrypted').empty().val(data)
	