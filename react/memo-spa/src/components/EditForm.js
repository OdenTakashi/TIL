export default function EditForm({isEditable, memoLists, updateMemo, handleEditMode, formContent, updateContent}) {
  const editingNumber = isEditable

  function saveMemo(number) {
    let element = document.getElementById('content')

    const memos = number <= memoLists.length ? memoLists.filter ((memo) => memo.id !== number) :  memoLists.concat()

    memos.push({id: editingNumber, title: element.value.split(/\n/)[0], body: element.value})
    updateMemo(memos)
    localStorage.setItem('memos', JSON.stringify(memos))
    handleEditMode()
  }

  function deleteMemo() {
    if (memoLists.some((memo) => memo.id === editingNumber)) {
      const memos = memoLists.filter((memo) => memo.id !== editingNumber)
      updateMemo(memos)
      localStorage.setItem('memos', JSON.stringify(memos))
    }
    handleEditMode()
  }

  if(isEditable) {
    return (
      <div className='text-sm w-1/2 m-auto mt-6'>
        <div className='mx-auto w-1/2'>
          <textarea className='border' id='content' placeholder='TODO: shopping' value={formContent} onChange={(e) => updateContent(e.target.value)}></textarea>
          <div>
            <button className='border p-1' onClick={() => saveMemo(editingNumber)}>Save</button>
            <button className='border ml-3 p-1' onClick={() => handleEditMode('')}>Cancel</button>
            <button className='border p-1 ml-3' onClick={() => deleteMemo()}>delete</button>
          </div>
        </div>
      </div>
    )
  }
}
