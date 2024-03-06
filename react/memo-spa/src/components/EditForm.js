export default function EditForm({isEditable, memoLists, storeMemo, handleEditMode, formContent, updateContent}) {
  const editingNumber = isEditable
  const memos = memoLists

  function saveMemo(number, memoList) {
    let serialNumber = setSerialNumber()
    let element = document.getElementById('content')

    if(number <= memoList.length) {
      const items = memoList.filter ((memo) => memo.id !== number)
      items.push({id: number, body: element.value})
      storeMemo(items)
      debugger
      localStorage.setItem('memos', JSON.stringify(items)) 
      handleEditMode()
    } else {
      const memos = memoLists.concat()
      memos.push({id: serialNumber, body: element.value})
      storeMemo(memos)
      localStorage.setItem('memos', JSON.stringify(memos))
      handleEditMode()
    }
  }

  function setSerialNumber() {
    return memoLists.length === 0 ? 1 : memoLists[memoLists.length - 1].id + 1
  }

  if(isEditable) {
    return (
      <div className='text-sm w-1/2 m-auto mt-6'>
        <textarea className='border' id='content' value={formContent} onChange={(e) => updateContent(e.target.value)}></textarea>
        <div>
          <button className='border' onClick={() => saveMemo(editingNumber, memos)}>Save</button>
        </div>
      </div>
    )
  }
}
