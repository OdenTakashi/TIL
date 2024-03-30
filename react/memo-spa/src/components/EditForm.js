export default function EditForm({isEditable, memoLists, updateMemo, handleEditMode, formContent, updateContent}) {
  const editingNumber = isEditable
  const memoPlaceholder = 'TODO: Today Task \n- Running \n- Coding'
  function saveMemo(number) {
    let element = document.getElementById('content')

    if (element.value) {
      const memos = number <= memoLists.length ? memoLists.filter ((memo) => memo.id !== number) :  memoLists.concat()

      memos.push({id: editingNumber, title: element.value.split(/\n/)[0], body: element.value})
      updateMemo(memos)
      localStorage.setItem('memos', JSON.stringify(memos))
      handleEditMode()
    } else {
      alert('メモを追加してください')
    }
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
          <textarea className='border rounded p-2' rows='10' cols='50' id='content' placeholder={memoPlaceholder} value={formContent} onChange={(e) => updateContent(e.target.value)}></textarea>
          <div className='flex justify-end items-end mt-3 m-auto'>
            <button className='w-1/3 h-10 bg-indigo-700 text-white border p-1 rounded hover:bg-indigo-800' onClick={() => saveMemo(editingNumber)}>Save</button>
            <button className='ml-3 p-1 rounded underline hover:no-underline' onClick={() => handleEditMode('')}>Cancel</button>
            <button className='p-1 ml-3 rounded underline hover:no-underline' onClick={() => deleteMemo()}>delete</button>
          </div>
        </div>
      </div>
    )
  }
}
