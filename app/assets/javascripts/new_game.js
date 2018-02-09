const generateOptions = function (playerArray) {
  const otherPlayerSelect = $('select.other-player1')
  return playerArray.map( function(player) {
    const option = $('<option></option>')
    option.val(player.id)
    option.text(player.name)

    return option
  })
}

$(function() {
  $('.my-team').change(function() {
    const ourTeamId = $('.my-team option:selected').val()
    $.ajax({
      url: '/teams/options',
      data: {
        team: {
          id: ourTeamId
        }
      },
      method: 'GET',
      success: function (res) {
        generateOptions(res).map( function(option) {
          return $('.other-player1').append(option)
        })
        generateOptions(res).map( function(option) {
          return $('.other-player2').append(option)
        })
      }
    })
  });

  $('.other-player1').change(function() {
    const team2player1Id = $('.other-player1 option:selected').val()

    $('.other-player2 option').each(function() {
      if($(this).val() === team2player1Id ) {
        $(this).remove()
      } else {
        $(this).css('display', 'block')
      }
    })
  })
})

