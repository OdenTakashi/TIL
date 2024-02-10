export default function EditForm({isEditable}) {
  function saveMemo() {
    let element = document.getElementById('content')
    localStorage.setItem('memos', JSON.stringify([{"id": "1", "body": element.value}]))
  }

  if(isEditable) {
    return (
      <div className='text-sm'>
        <textarea className='border' id='content'></textarea>
        <div>
          <button className='border' onClick={saveMemo}>Save</button>
        </div>
      </div>
    )
  }
}
