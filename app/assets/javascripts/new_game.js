$(function() {
  $('.my-team').change(function() {
    const playerId = Number($('.my-team option:selected').attr('data-player-id'));
    $('.other-team option').each(function() {
      if (!$(this).val()) return

      const teamPlayerIds = JSON.parse($(this).attr('data-player-ids'));

      if(teamPlayerIds.indexOf(playerId) > -1) {
        $(this).css('display', 'none')
      } else {
        $(this).css('display', 'block')
      }
    })
  });
})

