-- leader key
map("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Window navigation
nmap("<C-h>", "<C-w>h")
nmap("<C-j>", "<C-w>j")
nmap("<C-k>", "<C-w>k")
nmap("<C-l>", "<C-w>l")

nmap("<C-Up>", "<CMD>resize +2<CR>")
nmap("<C-Down>", "<CMD>resize -2<CR>")
nmap("<C-Left>", "<CMD>vertical resize +2<CR>")
nmap("<C-Right>", "<CMD>vertical resize -2<CR>")

-- Buffer navigation
nmap("<S-j>", "<CMD>bnext<CR>")
nmap("<S-k>", "<CMD>CMD>bprivious<CR>")
nmap("<Leader>q", "<CMD>Bdelete<CR>")

-- Keep selecti<CMD>n
vmap("<", "<gv")
vmap(">", ">gv")
vmap("=", "=gv")

-- Move text up and down
nmap("<A-j>", "<CMD>m .+1<CR>==")
nmap("<A-k>", "<CMD>m .-2<CR>==")
vmap("<A-j>", "<CMD>m .+1<CR>==gv")
vmap("<A-k>", "<CMD>m .-2<CR>==gv")

-- Simpler clipboard past
vmap("p", "\"_dP")
xmap("<C-A-y>", "\"+ygv")
nmap("<C-A-y>", "\"+yy")
nmap("<C-A-p>", "\"+P")
vmap("<C-A-p>", "\"_d\"+P")

-- commenting
nmap("<A-/>", "gcc")
xmap("<A-/>", "gc")

-- nvim tree
nmap("<Leader>e", "<CMD>NvimTreeToggle<CR>")
nmap("<Leader>fe", "<CMD>NvimTreeFindFile<CR>")

-- telescope
nmap("<Leader>sf", "<CMD>Telescope find_files<CR>")
nmap("<Leader>st", "<CMD>Telescope live_grep<CR>")
nmap("<Leader>sp", "<CMD>Telescope projects<CR>")
nmap("<Leader>sb", "<CMD>Telescope buffers<CR>")
nmap("<Leader>sd", "<CMD>Telescope diagnostics<CR>")

-- helper
nmap("<Leader>h", "<CMD>noh<CR>")
