class Dashing.RpaWig extends Dashing.Widget
  @accessor 'current', Dashing.AnimatedValue
  # @accessor 'comp_record', Dashing.AnimatedValue
  # @accessor 'difference', ->
  #   console.log("Calculating difference...")
  #   totalProcessed = @get('total_records_processed')
  #   totalFailed = @get('total_failed_records')
  #   if totalProcessed and totalFailed
  #     diff = Math.abs(Math.round((totalFailed - totalProcessed) / totalProcessed * 100))
  #     "#{diff}%"
  #   else
  #     "100%"


  onData: (data) ->
    # console.log('New data received:', data)
    if data.status
      # clear existing "status-*" classes
      $(@get('node')).attr 'class', (i,c) ->
        c.replace /\bstatus-\S+/g, ''
      # add new class
      $(@get('node')).addClass "status-#{data.status}"

    @updateColor(data)
    

    
  redirect: (data) ->
    if data? and data.innerText.trim() isnt ""
        link_data = data.innerText.split("\n")[1]
        console.log(link_data)
        location.href = 'execution_data?bot_name=' + encodeURIComponent(link_data)
        # location.href = 'execution_data'
    else
        console.log("not exist")
    
  updateColor: (data) ->
    console.log('New data received:',data, data.dataid)
    selector = "div[data-id='" + data.dataid + "']"
    rpaElements = $(selector)
    rpaElements.each (index, element) ->

      current = data.current
      if current < 25
        $(element).css "background-color", "#ff3333"
      else if current < 50
        $(element).css "background-color", "#ffa233"
      else if current < 75
        $(element).css "background-color", "#ffd700"
      else
        $(element).css "background-color", "#3ca309"
