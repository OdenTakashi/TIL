export default function EditForm({isEditable, memoLists, updateMemo, handleEditMode, formContent, updateContent}) {
  const editingNumber = isEditable

  function saveMemo(number) {
    let serialNumber = setSerialNumber()
    let element = document.getElementById('content')

    if(number <= memoLists.length) {
      const items = memoLists.filter ((memo) => memo.id !== number)
      items.push({id: number, body: element.value})
      updateMemo(items)
      localStorage.setItem('memos', JSON.stringify(items)) 
      handleEditMode()
    } else {
      const memos = memoLists.concat()
      memos.push({id: serialNumber, body: element.value})
      updateMemo(memos)
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
        <div className='mx-auto w-1/2'>
          <textarea className='border' id='content' value={formContent} onChange={(e) => updateContent(e.target.value)}></textarea>
          <div>
            <button className='border' onClick={() => saveMemo(editingNumber)}>Save</button>
          </div>
        </div>
      </div>
    )
  }
}
