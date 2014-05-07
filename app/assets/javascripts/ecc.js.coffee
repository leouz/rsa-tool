$ ->  
  $('#eliptic-groups .calc').click ->
    d =
      p: $('#eliptic-groups #ecc_p').val()
      a: $('#eliptic-groups #ecc_a').val()
      b: $('#eliptic-groups #ecc_b').val()
    if d.p and d.a and d.b
      $.ajax
        type: "POST"
        url: "/ecc/eliptic-groups"
        cache: false
        data: d
        success: (data) ->
          $('#eliptic-groups #result').empty()
          createTr = (d) ->
            $('#eliptic-groups #result').append(
              $('<tr>').append(
                  $('<td>').append(d.sieve),                   
                  $('<td>').append(d.y1), 
                  $('<td>').append(d.y2),                   
                  $('<td>').append(d.is_valid.toString())))
          createTr(d) for d in data

  $('#sum .calc').click ->
    d =
      x1: $('#sum #ecc_x1').val()
      y1: $('#sum #ecc_y1').val()
      x2: $('#sum #ecc_x2').val()
      y2: $('#sum #ecc_y2').val()
      p: $('#sum #ecc_p').val()
      a: $('#sum #ecc_a').val()    

    if d.x1 and d.y1 and d.x2 and d.y2 and d.p
      $.ajax
        type: "POST"
        url: "/ecc/#{$(this).attr('operation')}"
        cache: false
        data: d
        success: (data) ->
          $('#sum #result').empty().append(
            $('<tr>').append(
                $('<td>').append(data.lambda),
                $('<td>').append(data.x3),                   
                $('<td>').append(data.y3),
                $('<td>').append(data.message)))

  $('#product .calc').click ->
    d =
      x1: $('#product #ecc_x1').val()
      y1: $('#product #ecc_y1').val()
      p: $('#product #ecc_p').val()
      a: $('#product #ecc_a').val()    
      n: $('#product #ecc_n').val()    

    if d.x1 and d.y1 and d.p and d.a and d.n
      $.ajax
        type: "POST"
        url: "/ecc/product"
        cache: false
        data: d
        success: (data) ->
          $('#product #product-result').html(data.product)

          $('#product #binary').empty()
          $('#product #binary').append($('<td>').append(d)) for d in data.binary

          $('#product #binary-reverse').empty()
          $('#product #binary-reverse').append($('<td>').append(d)) for d in data.binary_reverse

          $('#product #sums').empty()
          $('#product #sums').append($('<td>').append("#{d[0]}, #{d[1]}")) for d in data.sums

          $('#product #log').empty()          
          createTr = (d) ->
            $('#product #log').append(
              $('<tr>').append(
                $('<td>').append(d.x1),
                $('<td>').append(d.y1),
                $('<td>').append(d.x2),
                $('<td>').append(d.y2),
                $('<td>').append(d.x3),
                $('<td>').append(d.y3),
                $('<td>').append(d.lambda),
                $('<td>').append(d.message)))
          createTr(d) for d in data.log